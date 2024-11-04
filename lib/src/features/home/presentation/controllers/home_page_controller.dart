import 'package:get/get.dart';

import '../../../../controllers/application_controller.dart';

class HomePageController extends GetxController {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    ApplicationController.instance.initializeApplicationData();
  }
}

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController());
  }
}
