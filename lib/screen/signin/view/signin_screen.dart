import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/constant.dart';
import 'package:firebase_miner/utils/helper/fire_helper.dart';
import 'package:firebase_miner/utils/text_theme.dart';
import 'package:firebase_miner/utils/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset('assets/img/login.png', height: 250)),
                Center(
                  child: Text(welcomeTitle, style: txtTitle),
                ),
                const SizedBox(height: 10),
                const Text(enterEmail),
                const SizedBox(height: 20),
                Text(email, style: txt18),
                CustomTextField(label: emailLabel, controller: txtEmail),
                const SizedBox(height: 10),
                Text(password, style: txt18),
                CustomTextField(
                    label: passwordLabel,
                    icon: Icons.remove_red_eye,
                    controller: txtPassword),
                const SizedBox(height: 60),
                Text(forgot, style: txtGreen),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(green)),
                    onPressed: () async {
                      String message = await FireHelper.fireHelper.signIn(
                          email: txtEmail.text, password: txtPassword.text);
                      Get.snackbar(message, '');
                      if (message == "Success") {
                        FireHelper.fireHelper.checkUser();
                        Get.offAllNamed('profile');
                      }
                    },
                    child: Text(loginButton, style: txt16),
                  ),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(dummy),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(green)),
                      onPressed: () {
                        Get.toNamed('signUp');
                      },
                      child: Text(createButton, style: txt16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
