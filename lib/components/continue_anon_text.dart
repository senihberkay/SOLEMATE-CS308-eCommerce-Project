import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/home_screen.dart';
import 'package:flutter_auth/screens/sign_up/sign_up_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class ContiuneAnonTExt extends StatelessWidget {
  const ContiuneAnonTExt({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, HomeScreen.routeName),
          child: Text(
            "Continue as anonymously",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16), color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
