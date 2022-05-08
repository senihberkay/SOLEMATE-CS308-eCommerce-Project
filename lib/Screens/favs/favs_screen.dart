import 'package:flutter/material.dart';

import 'components/body.dart';

class FavsScreen extends StatelessWidget {
  static String routeName = "/favs";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
      ),
      body: Body(),
    );
  }
}
