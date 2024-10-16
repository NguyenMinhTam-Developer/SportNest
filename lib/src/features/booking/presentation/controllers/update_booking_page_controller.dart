import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../data/models/booking_model.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../services/authentication_service.dart';
import '../../../../shared/extensions/hardcode.dart';
import 'booking_detail_page_controller.dart';
import 'booking_list_page_controller.dart';

class UpdateBookingPageController extends GetxController {
  BookingModel initialBooking = Get.arguments as BookingModel;

  final String _venueId = Get.parameters['venueId']!;
  final String _bookingId = Get.parameters['bookingId']!;

  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  Future<List<VenueModel>>? venues;
  Future<List<UnitModel>>? units;

  bool isLoading = false;

  @override
  Future<void> onReady() async {
    super.onReady();

    venues = FirebaseFirestoreSource().fetchVenueList(AuthService().user!.uid);
    formKey.currentState?.fields['venueId']?.didChange(initialBooking.venueId);
    formKey.currentState?.patchValue({"venueId": initialBooking.venueId});

    units = FirebaseFirestoreSource().fetchUnitList(_venueId);

    formKey.currentState?.fields['unitId']?.didChange(initialBooking.unitId);
    formKey.currentState?.patchValue({"unitId": initialBooking.unitId});

    update();
  }

  Future<void> onVenueChanged(String? value) async {
    if (value == null) return;

    formKey.currentState?.patchValue({"unitId": null});

    units = FirebaseFirestoreSource().fetchUnitList(value);

    update();
  }

  Future<void> onSubmitPressed() async {
    if (formKey.currentState!.saveAndValidate()) {
      isLoading = true;
      update();

      final formData = formKey.currentState!.value;
      final venueId = formData['venueId'] as String;
      final unitId = formData['unitId'] as String;
      final date = formData['date'] as DateTime;
      final startTime = formData['startTime'] as DateTime;
      final endTime = formData['endTime'] as DateTime;

      final startDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        startTime.hour,
        startTime.minute,
      );

      final endDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        endTime.hour,
        endTime.minute,
      );

      final updatedBooking = initialBooking.copyWith(
        venueId: venueId,
        unitId: unitId,
        startTime: startDateTime,
        endTime: endDateTime,
        contactName: formData['contactName'] as String,
        phoneNumber: formData['phoneNumber'] as String,
        status: formData['status'] as String,
      );

      try {
        await FirebaseFirestoreSource().updateBooking(updatedBooking);
        await BookingDetailPageController.instance.fetchBooking(_bookingId);
        await BookingListPageController.instance.fetchBookings(_venueId);
        Get.back();
        Get.snackbar(
          'Success!'.isHardcoded,
          'Booking updated successfully'.isHardcoded,
        );
      } catch (e) {
        Get.snackbar(
          'Alert!'.isHardcoded,
          'Failed to update booking'.isHardcoded,
        );
      } finally {
        isLoading = false;
        update();
      }
    } else {
      autovalidateMode = AutovalidateMode.always;
      update();
    }
  }
}

class UpdateBookingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateBookingPageController>(() => UpdateBookingPageController());
  }
}
