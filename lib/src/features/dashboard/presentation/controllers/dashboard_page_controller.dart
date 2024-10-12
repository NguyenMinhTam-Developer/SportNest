import 'package:get/get.dart';

class DashboardPageController extends GetxController {
  //
}

class DashboardPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardPageController>(() => DashboardPageController());
  }
}
