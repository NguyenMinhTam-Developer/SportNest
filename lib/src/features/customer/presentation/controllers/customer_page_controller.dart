import 'package:get/get.dart';

class CustomerPageController extends GetxController {
  //
}

class CustomerPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerPageController>(() => CustomerPageController());
  }
}
