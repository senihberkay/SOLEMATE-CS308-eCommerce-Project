import 'package:flutter/material.dart';

import 'components/body.dart';

class SigninSuccessScreen extends StatelessWidget {
  static String routeName = "/sigin_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Sign In Success"),
      ),
      body: Body(),
    );
  }
}
