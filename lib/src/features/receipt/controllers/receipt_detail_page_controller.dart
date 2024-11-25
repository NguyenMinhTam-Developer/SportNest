import 'package:get/get.dart';
import '../../../controllers/application_controller.dart';
import '../../../data/models/receipt_model.dart';
import '../../booking/presentation/controllers/booking_detail_page_controller.dart';

import '../../../data/sources/firebase/firebase_firestore_source.dart';

class ReceiptDetailPageController extends GetxController {
  late final String? _receiptId = Get.parameters['receiptId'];

  Future<ReceiptModel>? fetchReceiptFuture;
  ReceiptModel? receipt;

  Future<void> _fetchReceipt() async {
    fetchReceiptFuture = FirebaseFirestoreSource().fetchReceiptDetail(_receiptId!);
    receipt = await fetchReceiptFuture;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    _fetchReceipt();
  }

  Future<void> onCheckoutPressed() async {
    fetchReceiptFuture = FirebaseFirestoreSource().checkout(_receiptId!);

    // Update the booking detail page data
    try {
      BookingDetailPageController.instance.fetchBooking(receipt!.bookingId);
    } catch (e) {
      print(e);
    }

    await ApplicationController.instance.asyncBookingData();

    update();
  }
}
