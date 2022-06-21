//import 'dart:js';

import 'package:flutter/widgets.dart';
import 'package:flutter_auth/Screens/favs/favs_screen.dart';
import 'package:flutter_auth/Screens/my_account/account_screen.dart';
import 'package:flutter_auth/screens/cart/cart_screen.dart';
import 'package:flutter_auth/screens/complete_profile/complete_profile_screen.dart';
import 'package:flutter_auth/screens/details/details_screen.dart';
import 'package:flutter_auth/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter_auth/screens/home/home_screen.dart';
import 'package:flutter_auth/screens/login_success/login_success_screen.dart';
import 'package:flutter_auth/screens/otp/otp_screen.dart';
import 'package:flutter_auth/screens/profile/profile_screen.dart';
import 'package:flutter_auth/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_auth/screens/splash/splash_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'package:flutter_auth/Screens/checkout/checkout_screen.dart';
import 'package:flutter_auth/Screens/product_details/product_details_screen.dart';
import 'package:flutter_auth/Screens/sigin_success/sigin_success_screen.dart';
import 'package:flutter_auth/Screens/settings/settings_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SigninSuccessScreen.routeName: (context) => SigninSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  FavScreen.routeName: (context) => FavScreen(),
  AccountScreen.routeName: (context) => AccountScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
  CheckoutScreen.routeName: (context) => CheckoutScreen(),
  ProductDetailsScreen.routeName: (context) => ProductDetailsScreen()
};
