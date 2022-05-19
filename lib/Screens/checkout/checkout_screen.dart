import 'package:flutter/material.dart';

import 'components/body.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../constants.dart';
import './components/background.dart';

import 'dart:math';

class CheckoutScreen extends StatefulWidget {
  static String routeName = "/checkout";

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;
  dynamic data;
  var cart = [];
  String notiID = '';


  Future<void> getData() async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);
    final CollectionReference collection = FirebaseFirestore.instance.collection('users');
    await collection.doc(currentUser!.uid).get().then((DocumentSnapshot snapshot) async {
      data = snapshot.data();
      setState(() {
        cart = data['cart'];
      });
    });
  }

  Future<void> placeOrder() async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);
    await FirebaseFirestore.instance.collection('orders').doc(notiID).set({
      'cart': cart,
      'uid': currentUser!.uid,
    });

  }

  _CheckoutScreenState() {
    getData();
    var rng = Random();
    for (int i = 0; i < 8; i++){
      notiID += rng.nextInt(9).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Out"),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Check Out",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(height: size.height * 0.03),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Your Address",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Card Number",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Date",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "CVV",
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "Place Order",
                press: () {placeOrder();},
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}