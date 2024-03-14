import 'package:firebase_miner/screen/dash/view/dash_screen.dart';
import 'package:firebase_miner/screen/intro/view/intro_screen.dart';
import 'package:firebase_miner/screen/profile/view/profile_screen.dart';
import 'package:firebase_miner/screen/signin/view/signin_screen.dart';
import 'package:firebase_miner/screen/signup/view/signup_screen.dart';
import 'package:firebase_miner/screen/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> screen_routes = {
  '/': (context) => const SplashScreen(),
  'intro': (context) => const IntroScreen(),
  'signIn': (context) => const SignInScreen(),
  'signUp': (context) => const SignUpScreen(),
  'dash': (context) => const DashScreen(),
  'profile': (context) => const ProfileScreen(),
};
