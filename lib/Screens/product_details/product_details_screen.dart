import 'package:flutter/material.dart';

import 'components/body.dart';

class ProductDetailsScreen extends StatelessWidget {
  static var routeName = "/productDetails";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Product Details',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          centerTitle: true),
    );
  }
}
