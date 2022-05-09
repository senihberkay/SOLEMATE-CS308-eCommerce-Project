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

  Future<void> addToCart(Product product) async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);
    var cartItem = {
      'name': product.name,
      'brand': product.brand,
      'picture': product.pictureURLs[0],
      'ID': product.ID,
      'price': product.price,
      'quantity': 1,
    };

    var index = -1;
    if (cart.isNotEmpty) {
      index = cart.indexWhere((element) => element['ID'] == product.ID);
    }
    if (index != -1){
      var cartItem = cart[index];
      cartItem['quantity'] = cartItem['quantity'] + 1;
      cart[index] = cartItem;
    }
    else {
      cart.add(cartItem);
    }
    final CollectionReference collection = FirebaseFirestore.instance.collection('users');
    await collection.doc(currentUser!.uid).update({
      'cart': cart,
    });
  }

  Future<void> getData() async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);
    final CollectionReference collection = FirebaseFirestore.instance.collection('users');
    collection.doc(currentUser!.uid).get().then((DocumentSnapshot snapshot) async {
      data = snapshot.data();
      cart = data['cart'];
    });
  }

  _BodyState() {
    getData();
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
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () {addToCart(widget.product);},
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
