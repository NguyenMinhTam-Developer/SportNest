import 'package:get/get.dart';
import '../controllers/update_receipt_page_controller.dart';

class UpdateReceiptPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateReceiptPageController());
  }
}
