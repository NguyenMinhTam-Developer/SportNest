import 'package:get/get.dart';
import 'package:sport_nest_flutter/generated/locales.g.dart';
import '../../../../shared/extensions/x_datetime.dart';
import '../../../../data/params/update_booking_status_param.dart';
import '../../../../data/params/update_booking_payment_status_param.dart';
import '../../../../data/enums/booking_status_enum.dart';
import '../../../../data/enums/payment_status_enum.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../core/services/notification_service.dart';

class BookingDetailPageController extends GetxController {
  late final String venueId;
  late final String bookingId;

  bool isUpdated = false;

  Future<BookingModel>? fetchBookingFuture;

  Future<void> fetchBooking(String id) async {
    fetchBookingFuture = FirebaseFirestoreSource().fetchBooking(id);
    update();
  }

  Future<void> deleteBooking(BookingModel booking) async {
    try {
      await NotificationService().cancelBookingNotification(
        booking.numericId,
      );

      await FirebaseFirestoreSource().deleteBooking(bookingId);
      isUpdated = true;
      Get.back(result: true);
    } catch (e) {
      Get.snackbar(
        LocaleKeys.error.tr,
        LocaleKeys.failedToDeleteBooking.tr,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void updateBookingStatus(BookingStatusEnum status) async {
    try {
      final booking = await FirebaseFirestoreSource().updateBookingStatus(
        UpdateBookingStatusParam(
          id: bookingId,
          status: status,
        ),
      );

      isUpdated = true;

      if (status == BookingStatusEnum.cancelled) {
        await NotificationService().cancelBookingNotification(
          booking.numericId,
        );
      } else {
        await NotificationService().scheduleBookingNotification(
          bookingId: booking.numericId,
          title: 'Upcoming Booking',
          body: 'Your booking at ${booking.venue?.name} is scheduled for ${booking.startTime?.toDate().formatDate()}',
          scheduledDate: booking.startTime!.toDate().subtract(const Duration(minutes: 10)),
        );
      }

      fetchBooking(bookingId);
      update();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update booking status',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void updatePaymentStatus(String bookingId, PaymentStatusEnum status) async {
    try {
      await FirebaseFirestoreSource().updateBookingPaymentStatus(
        UpdateBookingPaymentStatusParam(
          id: bookingId,
          paymentStatus: status,
        ),
      );
      isUpdated = true;
      fetchBooking(bookingId);
      update();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update payment status',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
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
