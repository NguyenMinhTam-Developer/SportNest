import 'package:get/get.dart';

class SchedulePageController extends GetxController {
  //
}

class SchedulePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchedulePageController>(() => SchedulePageController());
  }
}
