import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/constant.dart';
import 'package:firebase_miner/utils/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                const Text(
                  welcomeTitle,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(enterEmail),
                const SizedBox(height: 20),
                const Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                CustomTextField(label: emailLabel),
                const SizedBox(height: 10),
                const Text(
                  'Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                CustomTextField(label: password, icon: Icons.remove_red_eye),
                const SizedBox(height: 60),
                Text(
                  'Forget Password ??',
                  style: TextStyle(color: green),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(green)),
                    onPressed: () {},
                    child: Text(
                      'Login ->',
                      style: TextStyle(color: white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Don`t Have an Account?'),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(green)),
                      onPressed: () {
                        Get.toNamed('signUp');
                      },
                      child: Text(
                        'Create Account',
                        style: TextStyle(color: white, fontSize: 16),
                      ),
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
