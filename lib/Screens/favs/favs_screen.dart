import 'package:flutter/material.dart';

import 'components/body.dart';

class FavsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavsScreenState();
  }
}

class _FavsScreenState extends State<FavsScreen> {
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
