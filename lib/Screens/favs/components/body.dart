import 'package:flutter/material.dart';
import 'package:flutter_auth/components/custom_surfix_icon.dart';
import 'package:flutter_auth/components/default_button.dart';
import 'package:flutter_auth/components/form_error.dart';
import 'package:flutter_auth/components/no_account_text.dart';
import 'package:flutter_auth/size_config.dart';
import 'package:flutter_auth/models/Product.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Favourites",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
