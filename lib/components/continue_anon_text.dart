import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/home_screen.dart';
import '../size_config.dart';

class ContinueAnonText extends StatelessWidget {
  const ContinueAnonText({
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
