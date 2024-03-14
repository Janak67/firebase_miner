import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/constant.dart';
import 'package:firebase_miner/utils/helper/share_helper.dart';
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
                title: '',
                body: intro1,
                image: Image.asset('assets/img/intro.png'),
                decoration: PageDecoration(pageColor: whiteCyan)),
            PageViewModel(
                title: '',
                body: intro2,
                image: Image.asset('assets/img/intro1.png'),
                decoration: PageDecoration(pageColor: whiteCyan)),
            PageViewModel(
                title: '',
                body: intro3,
                image: Image.asset('assets/img/intro2.png'),
                decoration: PageDecoration(pageColor: whiteCyan)),
          ],
          showDoneButton: true,
          onDone: () {
            ShareHelper shr = ShareHelper();
            shr.setIntroStatus();
            Get.offAllNamed('signIn');
          },
          done: const Text('Done'),
          showNextButton: true,
          next: const Text('Next'),
        ),
      ),
    );
  }
}
