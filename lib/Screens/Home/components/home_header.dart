import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/cart/cart_screen.dart';
// import 'package:flutter_auth/screens/cart/cart_screen.dart';

import 'package:flutter_auth/size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: 'SOLE',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.withOpacity(0.6),
                  fontSize: 27),
              children: const <TextSpan>[
                TextSpan(
                    text: 'MATE',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    )),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 10,
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () => Navigator.pushNamed(context, CartScreen.routeName),
            //press: () {},
          ),
          /*
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () {},
          ),
          */
        ],
      ),
    );
  }
}
