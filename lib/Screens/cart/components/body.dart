import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatefulWidget {
  var cart = [];
  Body({Key? key, required this.cart});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> deleteFromCart(String ID) async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);
    widget.cart.removeWhere((element) => element['ID'] == ID);
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    await collection.doc(currentUser!.uid).update({
      'cart': widget.cart,
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cart.isNotEmpty) {
      return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: ListView.builder(
          itemCount: widget.cart.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(widget.cart[index]['ID'].toString()),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                deleteFromCart(widget.cart[index]['ID']);
              },
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/Trash.svg"),
                    Spacer(),
                  ],
                ),
              ),
              child: CartCard(
                name: widget.cart[index]['name'],
                brand: widget.cart[index]['brand'],
                price: widget.cart[index]['price'],
                ID: widget.cart[index]['ID'],
                quantity: widget.cart[index]['quantity'],
                picture: widget.cart[index]['picture'],
              ),
            ),
          ),
        ),
      );
    }
    return Center(
      child: Text('No Products Yet :('),
    );
  }
}
