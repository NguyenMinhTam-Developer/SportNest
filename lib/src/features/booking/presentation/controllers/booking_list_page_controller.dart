import 'package:get/get.dart';

import '../../../../data/models/booking_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';

class BookingListPageController extends GetxController {
  Future<List<BookingModel>>? fetchBookingsFuture;

  Future<void> fetchBookings(String venueId) async {
    fetchBookingsFuture = FirebaseFirestoreSource().fetchBookingList(venueId);
    update();
  }

  static BookingListPageController get instance {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(BookingListPageController());
    }
  }

  @override
  void onInit() {
    fetchBookings(Get.parameters['venueId']!);
    super.onInit();
  }
}

class BookingListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingListPageController>(() => BookingListPageController());
  }
}
