import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashController extends GetxController {
  RxInt pageIndex = 0.obs;
  Rx<PageController> pageController = PageController().obs;
}
