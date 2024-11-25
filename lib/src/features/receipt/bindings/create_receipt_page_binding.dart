import 'package:get/get.dart';

import '../controllers/create_receipt_page_controller.dart';

class CreateReceiptPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateReceiptPageController());
  }
}
