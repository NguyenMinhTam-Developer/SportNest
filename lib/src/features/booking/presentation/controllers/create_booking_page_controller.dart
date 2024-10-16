import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sport_nest_flutter/src/features/booking/presentation/controllers/booking_list_page_controller.dart';

import '../../../../data/models/booking_model.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../services/authentication_service.dart';

class CreateBookingPageController extends GetxController {
  final String _initialVenueId = Get.parameters['venueId']!;

  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  Future<List<VenueModel>>? venues;
  Future<List<UnitModel>>? units;

  bool isLoading = false;

  @override
  Future<void> onReady() async {
    super.onReady();

    venues = FirebaseFirestoreSource().fetchVenueList(AuthService().user!.uid);

    units = FirebaseFirestoreSource().fetchUnitList(_initialVenueId);

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

      final newBooking = BookingModel(
        id: '',
        userId: AuthService().user!.uid,
        venueId: venueId,
        unitId: unitId,
        startTime: startDateTime,
        endTime: endDateTime,
        contactName: formData['contactName'] as String,
        phoneNumber: formData['phoneNumber'] as String,
        status: 'Pending',
      );

      try {
        await FirebaseFirestoreSource().createBooking(newBooking);
        await BookingListPageController().fetchBookings(venueId);
        Get.back();
      } catch (e) {
        Get.snackbar('Error', 'Failed to create booking');
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

class CreateBookingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateBookingPageController>(() => CreateBookingPageController());
  }
}
