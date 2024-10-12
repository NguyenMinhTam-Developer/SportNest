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
  late BookingModel initialBooking;
  List<VenueModel> venues = [];
  List<UnitModel> units = [];

  bool isLoading = false;

  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void onInit() {
    initialBooking = Get.arguments as BookingModel;

    fetchData();

    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading = true;
      update();
      venues = await FirebaseFirestoreSource().fetchVenueList(AuthService().user!.uid);
      units = await FirebaseFirestoreSource().fetchUnitList(initialBooking.venueId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch booking data');
    } finally {
      isLoading = false;
      update();
    }
  }

  void onVenueChanged(String? venueId) {
    if (venueId != null) {
      // fetchUnits(venueId);
    } else {
      units.clear();
    }
    formKey.currentState?.patchValue({'unitId': null});
    update();
  }

  Future<void> onSubmitPressed() async {
    if (formKey.currentState!.saveAndValidate()) {
      final formData = formKey.currentState!.value;
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
        venueId: formData['venueId'] as String,
        unitId: formData['unitId'] as String,
        startTime: startDateTime,
        endTime: endDateTime,
        contactName: formData['contactName'] as String,
        phoneNumber: formData['phoneNumber'] as String,
        status: formData['status'] as String,
      );

      try {
        isLoading = true;
        update();

        await FirebaseFirestoreSource().updateBooking(updatedBooking);

        await BookingDetailPageController.instance.fetchBooking(initialBooking.id);
        await BookingListPageController.instance.fetchBookings(initialBooking.venueId);

        isLoading = false;
        update();

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
      autovalidateMode = AutovalidateMode.onUserInteraction;
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
