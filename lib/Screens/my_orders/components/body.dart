import 'package:flutter/material.dart';
import 'package:flutter_auth/size_config.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "My Orders",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(22),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  height: getProportionateScreenHeight(0.01),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
