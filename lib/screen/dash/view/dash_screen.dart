import 'package:firebase_miner/screen/contacts/view/contact_screen.dart';
import 'package:firebase_miner/screen/dash/controller/dash_controller.dart';
import 'package:firebase_miner/screen/home/view/home_screen.dart';
import 'package:firebase_miner/screen/setting/view/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  DashController controller = Get.put(DashController());
  List<Widget> screen = [
    const HomeScreen(),
    const ContactScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => PageView(
            controller: controller.pageController.value,
            onPageChanged: (value) {
              controller.pageIndex.value = value;
            },
            children: screen,
          ),
        ),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            destinations: const [
              NavigationDestination(icon: Icon(Icons.chat), label: 'Chats'),
              NavigationDestination(
                  icon: Icon(Icons.contacts), label: 'Contact'),
              NavigationDestination(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
            selectedIndex: controller.pageIndex.value,
            onDestinationSelected: (value) {
              controller.pageController.value.animateToPage(value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn);
              controller.pageIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
