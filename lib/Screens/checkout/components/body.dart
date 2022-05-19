import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/custom_surfix_icon.dart';
import 'package:flutter_auth/components/default_button.dart';
import 'package:flutter_auth/components/form_error.dart';
import 'package:flutter_auth/components/no_account_text.dart';
import 'package:flutter_auth/size_config.dart';
import 'package:flutter_auth/models/Product.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../constants.dart';
import 'background.dart';

import 'dart:math';

class Body extends StatefulWidget {
  var cart = [];
  Body({Key ? key, required this.cart});
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  FirebaseAuth auth = FirebaseAuth.instance;

  String notiID = '';

  _BodyState() {
    var rng = Random();
    for (int i = 0; i < 8; i++){
      notiID += rng.nextInt(9).toString();
    }

  }

  Future<void> placeOrder() async {
    print('hHAHAHHAHA');
    User? currentUser = auth.currentUser;
    assert(currentUser != null);
    await FirebaseFirestore.instance.collection('orders').doc(notiID).set({
      'cart': widget.cart,
      'uid': currentUser!.uid,
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
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
    );
  }
}