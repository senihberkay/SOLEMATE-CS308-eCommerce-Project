import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/profile/profile_screen.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import '../../size_config.dart';

import 'components/body.dart';

// class AccountScreen extends StatelessWidget {
//   static String routeName = "/account";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Profile"),
//       ),
//       body: Body(),
//       //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
//     );
//   }
// }

class AccountScreen extends StatelessWidget {
  static String routeName = "/account";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Profile",
      home: Account(),
    );
  }
}

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(22),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  height: getProportionateScreenHeight(2),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: getProportionateScreenWidth(120),
                      height: getProportionateScreenHeight(120),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: getProportionateScreenWidth(4),
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/Profile Image.png"))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: getProportionateScreenHeight(40),
                          width: getProportionateScreenWidth(40),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: getProportionateScreenWidth(4),
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: kPrimaryColor,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.white,
                            iconSize: getProportionateScreenWidth(15),
                            onPressed: () {
                              print(
                                  "change profile foto"); // changing profile photo
                            },
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(35),
              ),
              buildTextField("Full Name", "Andras Istvan Arato", false),
              buildTextField("E-mail", "customer@gmail.com", false),
              buildTextField("Password", "password123", true),
              buildTextField("Location", "Istanbul, Turkey", false),
              SizedBox(
                height: getProportionateScreenHeight(85),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(50)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed(ProfileScreen.routeName);
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: kPrimaryColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(50)),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: "  " + labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: "   " + placeholder,
            alignLabelWithHint: true,
            hintStyle: TextStyle(
              fontSize: getProportionateScreenWidth(15),
              fontWeight: FontWeight.w500,
              color: Colors.black,
            )),
      ),
    );
  }
}
