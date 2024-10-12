import 'package:get/get.dart';

class SettingPageController extends GetxController {}

class SettingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingPageController>(() => SettingPageController());
  }
}
