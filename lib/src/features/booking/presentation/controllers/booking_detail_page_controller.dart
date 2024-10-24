import 'package:get/get.dart';
import 'package:sport_nest_flutter/src/features/venues/presentation/controllers/venue_detail_page_controller.dart';
import '../../../../data/params/update_booking_status_param.dart';

import '../../../../data/enums/booking_status_enum.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';

class BookingDetailPageController extends GetxController {
  late final String venueId;
  late final String bookingId;

  Future<BookingModel>? fetchBookingFuture;

  Future<void> fetchBooking(String id) async {
    fetchBookingFuture = FirebaseFirestoreSource().fetchBooking(id);
    update();
  }

  Future<void> deleteBooking(String id) async {
    await FirebaseFirestoreSource().deleteBooking(id);
    await VenueDetailPageController.instance.fetchBookingList(venueId);

    Get.back();
  }

  Future<void> onRejectPressed() async {
    fetchBookingFuture = FirebaseFirestoreSource().updateBookingStatus(
      UpdateBookingStatusParam(
        id: bookingId,
        status: BookingStatusEnum.cancelled,
      ),
    );

    VenueDetailPageController.instance.fetchBookingList(venueId);

    update();
  }

  Future<void> onConfirmPressed() async {
    fetchBookingFuture = FirebaseFirestoreSource().updateBookingStatus(
      UpdateBookingStatusParam(
        id: bookingId,
        status: BookingStatusEnum.confirmed,
      ),
    );

    VenueDetailPageController.instance.fetchBookingList(venueId);

    update();
  }

  @override
  void onInit() {
    venueId = Get.parameters['venueId']!;
    bookingId = Get.parameters['bookingId']!;

    fetchBooking(bookingId);
    super.onInit();
  }

  static BookingDetailPageController get instance {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(BookingDetailPageController());
    }
  }
}

class BookingDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingDetailPageController>(() => BookingDetailPageController());
  }
}
