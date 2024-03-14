import 'package:shared_preferences/shared_preferences.dart';

class ShareHelper {
  void setIntroStatus() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setBool('intro', true);
  }

  Future<bool?> getIntroStatus() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    bool? status = await shr.getBool('intro');
    return status;
  }
}
