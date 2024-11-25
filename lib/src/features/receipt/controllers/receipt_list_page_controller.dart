import 'package:get/get.dart';
import '../../../controllers/application_controller.dart';
import '../../../core/routes/pages.dart';
import '../../../data/models/receipt_model.dart';

class ReceiptListPageController extends GetxController {
  final ApplicationController applicationController = ApplicationController.instance;

  RxBool isLoading = false.obs;
  RxList<ReceiptModel> receipts = <ReceiptModel>[].obs;

  void onReceiptPressed(String id) => Get.toNamed(
        Routes.receiptDetail.replaceFirst(":receiptId", id),
        arguments: receipts.firstWhere((receipt) => receipt.id == id),
      );

  static ReceiptListPageController get instance {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(ReceiptListPageController());
    }
  }
}

class ReceiptListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiptListPageController>(() => ReceiptListPageController());
  }
}
