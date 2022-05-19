import 'package:flutter/material.dart';
import 'package:flutter_auth/models/Cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartCard extends StatefulWidget {
  CartCard({
    Key? key,
    required this.name,
    required this.brand,
    required this.picture,
    required this.price,
    required this.ID,
    required this.quantity,
  }) : super(key: key);

  final String name, brand, picture, price, ID;
  var quantity;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {

  FirebaseAuth auth = FirebaseAuth.instance;
  dynamic data;
  var cart = [];
  var quantity = 0;

  incrementQuantity(String ID) async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);
    setState(() {
      quantity += 1;
    });
    final CollectionReference collection = FirebaseFirestore.instance.collection('users');
    await collection.doc(currentUser!.uid).get().then((DocumentSnapshot snapshot) async {
      data = snapshot.data();
      setState(() {
        cart = data['cart'];
      });
    });
    var index = cart.indexWhere((element) => element['ID'] == widget.ID);
    var cartItem = cart[index];
    cartItem['quantity'] = cartItem['quantity'] + 1;
    cart[index] = cartItem;
    await collection.doc(currentUser.uid).update({
      'cart': cart,
    });
  }

  decrementQuantity() {

  }

  initState() {
    super.initState();
    setState(() {
      quantity = widget.quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 88,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(widget.picture),
                ),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  maxLines: 2,
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: "${widget.price} TL",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),

                  ),
                )
              ],
            ),
          ],
        ),


        Column(
          children: [
            Row(
              children: [
                IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.all(0),
                  icon: Icon(Icons.indeterminate_check_box),
                  onPressed: (){

                  },
                ),
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
                  onPressed: (){
                    incrementQuantity(widget.ID);
                  },
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
