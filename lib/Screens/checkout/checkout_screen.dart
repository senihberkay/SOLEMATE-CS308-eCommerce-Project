import 'package:flutter/material.dart';

import 'components/body.dart';

class CheckoutScreen extends StatelessWidget {
  static String routeName = "/checkout";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Out"),
      ),
      body: Body(),
    );
  }
}
