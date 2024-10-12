import 'package:get/get.dart';

import '../../../../data/models/booking_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';

class BookingPageController extends GetxController {
  RxList<BookingModel> bookings = <BookingModel>[].obs;

  Future<void> fetchBookings() async {
    bookings.value = await FirebaseFirestoreSource().fetchBookingList("");
  }

  static BookingPageController get instance {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(BookingPageController());
    }
  }

  @override
  void onInit() {
    fetchBookings();
    super.onInit();
  }
}

class BookingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingPageController>(() => BookingPageController());
  }
}
