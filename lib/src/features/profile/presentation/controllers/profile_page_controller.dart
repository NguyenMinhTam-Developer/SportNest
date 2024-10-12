import 'package:get/get.dart';

class ProfilePageController extends GetxController {
  //
}

class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePageController>(() => ProfilePageController());
  }
}
