import 'package:flutter/material.dart';

import 'components/body.dart';


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
