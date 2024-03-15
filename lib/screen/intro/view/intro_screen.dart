import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/constant.dart';
import 'package:firebase_miner/utils/helper/share_helper.dart';
import 'package:firebase_miner/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          pages: [
            PageViewModel(
                title: 'Start with a greeting',
                body: intro1,
                image: Image.asset('assets/img/intro.png'),
                decoration:
                    PageDecoration(pageColor: whiteCyan, bodyTextStyle: txt20)),
            PageViewModel(
                title: 'Explain who you are',
                body: intro2,
                image: Image.asset('assets/img/intro1.png'),
                decoration:
                    PageDecoration(pageColor: whiteCyan, bodyTextStyle: txt20)),
            PageViewModel(
                title: 'Include a call-to-action',
                body: intro3,
                image: Image.asset('assets/img/intro2.png'),
                decoration:
                    PageDecoration(pageColor: whiteCyan, bodyTextStyle: txt20)),
          ],
          showDoneButton: true,
          onDone: () {
            ShareHelper shr = ShareHelper();
            shr.setIntroStatus();
            Get.offAllNamed('signIn');
          },
          globalBackgroundColor: whiteCyan,
          showSkipButton: true,
          skipOrBackFlex: 0,
          nextFlex: 0,
          back: const Icon(Icons.arrow_back, color: Colors.red, size: 50),
          skip: const Text('Skip',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          next: const Text(
            'Next',
            style: TextStyle(fontSize: 15),
          ),
          done: const Text('Done',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          showNextButton: true,
        ),
      ),
    );
  }
}
