import 'package:flutter/material.dart';

import 'components/body.dart';

class FavsScreen extends StatefulWidget {
  static String routeName = "/favs";
  @override
  State<StatefulWidget> createState() {
    return _FavsScreenState();
  }
}

class _FavsScreenState extends State<FavsScreen> {
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
