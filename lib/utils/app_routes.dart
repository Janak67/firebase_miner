import 'package:firebase_miner/screen/signin/view/signin_screen.dart';
import 'package:firebase_miner/screen/signup/view/signup_screen.dart';
import 'package:firebase_miner/screen/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> screen_routes = {
  '/': (context) => const SplashScreen(),
  'signIn': (context) => const SignInScreen(),
  'signUp': (context) => const SignUpScreen(),
};
