import 'package:flutter/material.dart';
import 'package:flutter_auth/components/default_button.dart';
import 'package:flutter_auth/models/Product.dart';
import 'package:flutter_auth/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';
import 'package:flutter/cupertino.dart';

class Body extends StatefulWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseAuth auth = FirebaseAuth.instance;
  dynamic data;
  var cart = [];
  int currentIndex = -1;
  String currentValue = '';
  var quantity = 1;

  Future<void> addToCart(Product product) async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);

    var index = -1;
    if (cart.isNotEmpty) {
      index = cart.indexWhere((element) => element['ID'] == product.ID);
    }
    if (index != -1) {
      if (cart[index]['size'] == currentValue) {
        var cartItem2 = cart[index];
        cartItem2['quantity'] = cartItem2['quantity'] + quantity;
        cart[index] = cartItem2;
      } else {
        var cartItem = {
          'name': product.name,
          'brand': product.brand,
          'picture': product.pictureURLs[0],
          'ID': product.ID,
          'price': product.price,
          'quantity': quantity,
          'size': currentValue,
        };
        cart.add(cartItem);
      }
    } else {
      var cartItem = {
        'name': product.name,
        'brand': product.brand,
        'picture': product.pictureURLs[0],
        'ID': product.ID,
        'price': product.price,
        'quantity': quantity,
        'size': currentValue,
      };
      cart.add(cartItem);
    }
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    await collection.doc(currentUser!.uid).update({
      'cart': cart,
    });
  }

  Future<void> getData() async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    collection
        .doc(currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) async {
      data = snapshot.data();
      cart = data['cart'];
    });
  }

  _BodyState() {
    getData();
  }

  Future<void> showAlertDialog(
      String title, String message, Product product) async {
    bool isiOS = Platform.isIOS;
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: widget.product.sizesStocks.map((e) {
                        return ListTile(
                          minVerticalPadding: 0,
                          title: Text(e['size'].toString()),
                          trailing: Radio<dynamic>(
                            activeColor: Colors.orange,
                            value: e['size'],
                            groupValue: currentValue,
                            onChanged: (value) {
                              setState(() {
                                currentValue = value;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    currentValue != ''
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              quantity > 1
                                  ? IconButton(
                                      iconSize: 20,
                                      padding: const EdgeInsets.all(0),
                                      icon: Icon(Icons.indeterminate_check_box),
                                      onPressed: () {
                                        setState(() {
                                          quantity -= 1;
                                        });
                                      },
                                    )
                                  : const SizedBox(width: 50),
                              Text(
                                quantity.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  fontFamily: 'Open Sans',
                                ),
                              ),
                              IconButton(
                                iconSize: 20,
                                padding: const EdgeInsets.all(0),
                                icon: Icon(Icons.add_box_rounded),
                                onPressed: () {
                                  setState(() {
                                    quantity += 1;
                                  });
                                },
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: currentValue != ''
                      ? DefaultButton(
                          press: () {
                            addToCart(widget.product).then((e) {
                              Navigator.pop(context);
                            });
                          },
                          text: 'Add to Cart')
                      : Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: getProportionateScreenHeight(56),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                primary: Colors.white,
                                backgroundColor: Colors.grey,
                              ),
                              onPressed: null,
                              child: Text(
                                'Select a Size',
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(10),
                        ),
                        child: widget.product.sizesStocks.isNotEmpty
                            ? DefaultButton(
                                text: "View Available Sizes",
                                press: () {
                                  showAlertDialog(
                                      'Sizes available', 'lol', widget.product);
                                },
                              )
                            : TextButton(
                                child: Text('Out of Stock'),
                                onPressed: null,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
