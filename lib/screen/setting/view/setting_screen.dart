import 'package:firebase_miner/utils/constant.dart';
import 'package:firebase_miner/utils/helper/fire_helper.dart';
import 'package:firebase_miner/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(Icons.key, size: 26),
            TextButton(
              onPressed: () async {
                await FireHelper.fireHelper.logOut();
                Get.snackbar(logout, 'Success');
                Get.offAllNamed('signIn');
              },
              child: Text(logout, style: txt20),
            ),
          ],
        ),
      ),
    );
  }
}
