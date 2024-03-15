import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_miner/screen/setting/controller/setting_controller.dart';
import 'package:firebase_miner/utils/app_routes.dart';
import 'package:firebase_miner/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SettingController controller = Get.put(SettingController());
  runApp(
    Obx(
      () {
        controller.changeTheme();
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: controller.isLight.value ? lightTheme : darkTheme,
          routes: screen_routes,
          // initialRoute: 'intro',
        );
      },
    ),
  );
}
