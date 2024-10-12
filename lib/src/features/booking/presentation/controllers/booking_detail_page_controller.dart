import 'package:get/get.dart';

import '../../../../data/models/booking_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import 'booking_list_page_controller.dart';

class BookingDetailPageController extends GetxController {
  Future<BookingModel>? fetchBookingFuture;

  Future<void> fetchBooking(String id) async {
    fetchBookingFuture = FirebaseFirestoreSource().fetchBooking(id);
    update();
  }

  Future<void> deleteBooking(String id) async {
    await FirebaseFirestoreSource().deleteBooking(id);

    await BookingListPageController.instance.fetchBookings(
      Get.parameters['venueId']!,
    );

    Get.back();
  }

  static BookingDetailPageController get instance {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(BookingDetailPageController());
    }
  }

  @override
  void onInit() {
    fetchBooking(Get.parameters['bookingId']!);
    super.onInit();
  }
}

class BookingDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingDetailPageController>(() => BookingDetailPageController());
  }
}
