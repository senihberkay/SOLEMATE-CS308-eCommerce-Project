import 'package:flutter/material.dart';
import 'package:flutter_auth/components/coustom_bottom_nav_bar.dart';
import 'package:flutter_auth/enums.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key); // sonradan eklendi
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
