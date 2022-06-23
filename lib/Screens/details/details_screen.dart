import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

import '../../models/Product.dart';
import 'package:flutter_auth/Screens/details/components/body.dart';
import 'package:flutter_auth/Screens/details/components/custom_app_bar.dart';

class AppBarContent extends StatelessWidget {
  const AppBarContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        //preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[kPrimaryColor, kPrimaryLightColor]),
          ),
          child: const AppBarContent(),
        ),
        //child: CustomAppBar(rating: agrs.product.rating.toDouble()),
      ),
      body: Body(product: agrs.product),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
