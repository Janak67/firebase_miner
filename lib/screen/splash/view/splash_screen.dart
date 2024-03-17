import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/helper/fire_helper.dart';
import 'package:firebase_miner/utils/helper/share_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? status;

  @override
  void initState() {
    super.initState();
    bool isLogin = FireHelper.fireHelper.checkUser();
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Get.offAllNamed(status == false || status == null
            ? 'intro'
            : isLogin == false
                ? 'signIn'
                : 'dash');
      },
    );
    createdata();
  }

  void createdata() async {
    ShareHelper shr = ShareHelper();
    status = await shr.getIntroStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
