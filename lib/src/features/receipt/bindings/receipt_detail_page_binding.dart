import 'package:get/get.dart';

import '../controllers/receipt_detail_page_controller.dart';

class ReceiptDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReceiptDetailPageController());
  }
}
