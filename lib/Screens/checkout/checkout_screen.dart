import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import './components/background.dart';
import 'dart:math';
import 'components/api/pdf_api.dart';
import 'components/api/pdf_invoice_api.dart';
import 'components/models/customer.dart';
import 'components/models/invoice.dart';
import 'components/models/supplier.dart';


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
  var userName = 'user';
  String email = 'mail';


  Future<void> getData() async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);
    final CollectionReference collection = FirebaseFirestore.instance.collection('users');
    await collection.doc(currentUser!.uid).get().then((DocumentSnapshot snapshot) async {
      data = snapshot.data();
      setState(() {
        cart = data['cart'];
        email = data['email'];
      });
      setState(() {
        userName = data['user'];
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
        title: const Text("Check Out"),
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
                press: () async{
                  placeOrder();

                  final date = DateTime.now();
                  final dueDate = date.add(Duration(days: 7));

                  final invoice = Invoice(
                      supplier: Supplier(
                        name: 'SOLEMATE',
                        address: 'Sabanci University, Tuzla, Istanbul',
                        paymentInfo: 'https://paypal.me/sendmoniezz',
                      ),
                      customer: Customer(
                        name: userName,   //  currentUser?.displayName ?? 'customername',
                        address: email,   // currentUser?.email ?? 'customer@gmail.com',
                      ),
                      info: InvoiceInfo(
                        date: date,
                        dueDate: dueDate,
                        description: 'CS 308 project',
                        number: '${DateTime.now().year}-9999',
                      ),
                      items: List.generate(cart.length, (index) {
                        return InvoiceItem(
                            description: cart[index]['name'],
                            date: DateTime.now(),
                            quantity: cart[index]['quantity'],
                            vat: 0.18,
                            unitPrice: double.parse(cart[0]['price']));
                      }),

                  );

                  final pdfFile = await PdfInvoiceApi.generate(invoice);
                  PdfApi.openFile(pdfFile);

                  },
              ),

              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}