import 'package:get/get.dart';

import '../controllers/receipt_list_page_controller.dart';

class ReceiptListPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReceiptListPageController());
  }
}
