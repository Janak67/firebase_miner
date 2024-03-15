import 'package:firebase_miner/utils/helper/share_helper.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  // Theme
  RxBool isLight = true.obs;

  void changeTheme() async {
    ShareHelper shr = ShareHelper();
    bool? isTheme = await shr.getTheme();
    isLight.value = isTheme ?? false;
  }
}
