import 'package:flutter/material.dart';
import 'package:flutter_auth/size_config.dart';

import '../../../constants.dart';

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
//                 "Personal Information",
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





// asagidaki kodu acabilirsin duruma gore




// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodySate extends State<BodyState> {
//   bool showPassword = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding:
//             EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//         child: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: ListView(
//             children: [
//               Text(
//                 "Personal Information",
//                 style: TextStyle(
//                   fontSize: getProportionateScreenWidth(22),
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   height: getProportionateScreenHeight(1),
//                 ),
//               ),
//               SizedBox(
//                 height: getProportionateScreenHeight(15),
//               ),
//               Center(
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: getProportionateScreenWidth(120),
//                       height: getProportionateScreenHeight(120),
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                               width: getProportionateScreenWidth(4),
//                               color: Theme.of(context).scaffoldBackgroundColor),
//                           boxShadow: [
//                             BoxShadow(
//                                 spreadRadius: 2,
//                                 blurRadius: 10,
//                                 color: Colors.black.withOpacity(0.1),
//                                 offset: Offset(0, 10))
//                           ],
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                               fit: BoxFit.cover,
//                               image: AssetImage(
//                                   "assets/images/Profile Image.png"))),
//                     ),
//                     Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: Container(
//                           height: getProportionateScreenHeight(40),
//                           width: getProportionateScreenWidth(40),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               width: getProportionateScreenWidth(4),
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                             ),
//                             color: kPrimaryColor,
//                           ),
//                           child: Icon(
//                             Icons.edit,
//                             color: Colors.white,
//                           ),
//                         )),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: getProportionateScreenHeight(35),
//               ),
//               buildTextField("Full Name", "Andras Istvan Arato", false),
//               buildTextField("E-mail", "customer@gmail.com", false),
//               buildTextField("Password", "password123", true),
//               buildTextField("Location", "Istanbul, Turkey", false),
//               SizedBox(
//                 height: getProportionateScreenHeight(85),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   OutlineButton(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: getProportionateScreenWidth(50)),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text("CANCEL",
//                         style: TextStyle(
//                             fontSize: getProportionateScreenWidth(15),
//                             letterSpacing: 2.2,
//                             color: Colors.black)),
//                   ),
//                   RaisedButton(
//                     onPressed: () {},
//                     color: kPrimaryColor,
//                     padding: EdgeInsets.symmetric(
//                         horizontal: getProportionateScreenWidth(50)),
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     child: Text(
//                       "SAVE",
//                       style: TextStyle(
//                           fontSize: getProportionateScreenWidth(15),
//                           letterSpacing: 2.2,
//                           color: Colors.white),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(
//       String labelText, String placeholder, bool isPasswordTextField) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 35.0),
//       child: TextField(
//         obscureText: isPasswordTextField ? showPassword : false,
//         decoration: InputDecoration(
//             suffixIcon: isPasswordTextField
//                 ? IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.remove_red_eye,
//                       color: Colors.grey,
//                     ),
//                   )
//                 : null,
//             contentPadding: EdgeInsets.only(bottom: 5),
//             labelText: "  " + labelText,
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             hintText: "   " + placeholder,
//             alignLabelWithHint: true,
//             hintStyle: TextStyle(
//               fontSize: getProportionateScreenWidth(15),
//               fontWeight: FontWeight.w500,
//               color: Colors.black,
//             )),
//       ),
//     );
//   }
// }
