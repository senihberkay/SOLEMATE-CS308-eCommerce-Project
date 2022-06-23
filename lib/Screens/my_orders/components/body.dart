// import 'package:flutter/material.dart';
// import 'package:flutter_auth/size_config.dart';

// import '../../../constants.dart';

// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: SingleChildScrollView(
//         child: Padding(
//           padding:
//               EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: SizeConfig.screenHeight * 0.04),
//               Text(
//                 "My Orders",
//                 style: TextStyle(
//                   fontSize: getProportionateScreenWidth(22),
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   height: getProportionateScreenHeight(0.01),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/size_config.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0E0E0E),
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Orders",
          style: TextStyle(
              color: Colors.black, fontSize: getProportionateScreenWidth(22)),
        ),
      ),
      body: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  "LAST ORDERS",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: getProportionateScreenWidth(10)),
                ),
                Divider(
                  endIndent: 0.0,
                  height: getProportionateScreenHeight(20),
                  thickness: 1.0,
                ),
                SizedBox(height: getProportionateScreenHeight(1)),
                order(),
                order(),
                order(),
                order(),
                order(),
                order(),
                order(),
                order(),
                order(),
                order(),
                order(),
                order(),
              ],
            ),
          )),
    );
  }

  Widget order() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: getProportionateScreenHeight(100),
              width: getProportionateScreenWidth(60),
              child: Image.asset("assets/images/soulmate_logo.png"),
            ),
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "Adidas",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(17),
                  ),
                ),
                Text(
                  "22/06/2022,1:23PM",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: getProportionateScreenWidth(10),
                      fontWeight: FontWeight.w300),
                ),
              ],
            )),
            Container(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(0)),
              child: Column(children: <Widget>[
                Row(children: [
                  Text(
                    "Total:",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getProportionateScreenWidth(16),
                    ),
                  ),
                ]),
              ]),
            ),
            Container(
                child: Row(
              children: <Widget>[
                Row(children: [
                  Text(
                    "9000",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(15),
                    ),
                  ),
                  Text(
                    "TL",
                    style: TextStyle(color: Colors.grey),
                  ),
                ]),
                SizedBox(
                  width: getProportionateScreenWidth(0.1),
                ),
                IconButton(
                  padding:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  icon: Icon(Icons.arrow_forward_ios),
                  iconSize: getProportionateScreenWidth(10),
                  color: Colors.grey,
                  onPressed: () {
                    print("order icon works");
                  },
                )
              ],
            ))
          ]),
    );
  }
}
