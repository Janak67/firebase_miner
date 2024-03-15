import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/constant.dart';
import 'package:firebase_miner/utils/helper/fire_helper.dart';
import 'package:firebase_miner/utils/text_theme.dart';
import 'package:firebase_miner/utils/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    createTitle,
                    style: txtTitle,
                  ),
                ),
                const Text(signupDummy),
                const SizedBox(height: 10),
                socialLogin('assets/img/apple.png', socialApple),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    String sms = await FireHelper.fireHelper.googleSignIn();
                    Get.snackbar(sms, '');
                    if (sms == "Success") {
                      Get.offAllNamed('dash');
                    }
                  },
                  child: socialLogin('assets/img/google.png', socialGoogle),
                ),
                const SizedBox(height: 10),
                socialLogin('assets/img/facebook.png', socialFacebook),
                const SizedBox(height: 25),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    SizedBox(width: 10),
                    Text('OR'),
                    SizedBox(width: 10),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 25),
                Text(name, style: txt18),
                CustomTextField(label: nameLabel),
                const SizedBox(height: 15),
                Text(yourEmail, style: txt18),
                CustomTextField(label: emailLabel, controller: txtEmail),
                const SizedBox(height: 15),
                Text(password, style: txt18),
                CustomTextField(
                    label: newPassword,
                    icon: Icons.remove_red_eye,
                    controller: txtPassword),
                const SizedBox(height: 80),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(green)),
                    onPressed: () async {
                      String message = await FireHelper.fireHelper.signUp(
                          email: txtEmail.text, password: txtPassword.text);
                      Get.snackbar(message, '');
                    },
                    child: Text(registrationButton, style: txt16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container socialLogin(String img, String text) {
    return Container(
      height: 50,
      width: double.infinity,
      color: const Color(0xffF8F8F8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(img, height: 25, width: 25),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}
