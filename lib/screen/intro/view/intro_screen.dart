import 'package:firebase_miner/screen/setting/controller/setting_controller.dart';
import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/constant.dart';
import 'package:firebase_miner/utils/helper/share_helper.dart';
import 'package:firebase_miner/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Obx(
              () => controller.isLight.value == false
                  ? Image.asset(
                      'assets/img/bgDark.jpg',
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/img/bgLight.jpg',
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.cover,
                    ),
            ),
            IntroductionScreen(
              pages: [
                PageViewModel(
                  title: 'Start with a greeting',
                  body: intro1,
                  image: Image.asset('assets/img/intro.png'),
                  decoration: PageDecoration(
                      pageColor:
                          controller.isLight.value == false ? black : whiteCyan,
                      bodyTextStyle: GoogleFonts.comicNeue(fontSize: 21)),
                ),
                PageViewModel(
                  title: 'Explain who you are',
                  body: intro2,
                  image: Image.asset('assets/img/intro1.png'),
                  decoration: PageDecoration(
                      pageColor:
                          controller.isLight.value == false ? black : whiteCyan,
                      bodyTextStyle: GoogleFonts.comicNeue(fontSize: 21)),
                ),
                PageViewModel(
                  title: 'Include a call-to-action',
                  body: intro3,
                  image: Image.asset('assets/img/intro2.png'),
                  decoration: PageDecoration(
                      pageColor:
                          controller.isLight.value == false ? black : whiteCyan,
                      bodyTextStyle: GoogleFonts.comicNeue(fontSize: 21)),
                ),
              ],
              showDoneButton: true,
              onDone: () {
                ShareHelper shr = ShareHelper();
                shr.setIntroStatus();
                Get.offAllNamed('signIn');
              },
              globalBackgroundColor:
                  controller.isLight.value == false ? black : whiteCyan,
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
          ],
        ),
      ),
    );
  }
}
