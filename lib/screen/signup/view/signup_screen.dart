import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/widget/textfield_widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Text('Let’s Create account for enter into FlexUI Website.'),
                const SizedBox(height: 10),
                socialLogin('assets/img/apple.png', 'Continue with Apple'),
                const SizedBox(height: 10),
                socialLogin('assets/img/google.png', 'Continue with Google'),
                const SizedBox(height: 10),
                socialLogin('assets/img/facebook.png', 'Continue with Facebook'),
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
                buildText('First Name'),
                CustomTextField(label: 'Ex: Eliza Maguire'),
                const SizedBox(height: 15),
                buildText('Your Email'),
                CustomTextField(label: 'Ex: Maguire@FlexUI.com'),
                const SizedBox(height: 15),
                buildText('Password'),
                CustomTextField(
                    label: 'Create a password', icon: Icons.remove_red_eye),
                const SizedBox(height: 80),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(green)),
                    onPressed: () {},
                    child: Text(
                      'Create account ->',
                      style: TextStyle(color: white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text buildText(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  SizedBox socialLogin(String img, String text) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(img, height: 25, width: 25),
            const SizedBox(width: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}
