import 'package:firebase_miner/utils/color_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // bool isLogin = FireHelper.fireHelper.checkUser();
    Future.delayed(
      const Duration(seconds: 3),
          () {
        Get.offAllNamed('signIn');
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        body: Center(
          child: Lottie.asset(
            'assets/json/Animation.json',
            height: 150,
          ),
        ),
      ),
    );
  }
}
