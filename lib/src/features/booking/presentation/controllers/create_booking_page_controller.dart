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
  final venueId = Get.parameters['venueId']!;

  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  List<VenueModel> venues = [];
  List<UnitModel> units = [];

  bool isLoading = false;

  @override
  Future<void> onReady() async {
    super.onReady();

    venues = await FirebaseFirestoreSource().fetchVenueList(AuthService().user!.uid);

    formKey.currentState?.patchValue({"venueId": venueId});

    units = await FirebaseFirestoreSource().fetchUnitList(venueId);

    formKey.currentState?.patchValue({"unitId": units.first.id});

    update();
  }

  Future<void> onVenueChanged(String? value) async {
    if (value == null) return;

    formKey.currentState?.patchValue({"unitId": null});

    units = await FirebaseFirestoreSource().fetchUnitList(value);

    update();
  }

  Future<void> onSubmitPressed() async {
    if (formKey.currentState!.saveAndValidate()) {
      isLoading = true;
      update();

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

      final newBooking = BookingModel(
        id: '',
        userId: AuthService().user!.uid,
        venueId: formData['venueId'] as String,
        unitId: formData['unitId'] as String,
        startTime: startDateTime,
        endTime: endDateTime,
        contactName: formData['contactName'] as String,
        phoneNumber: formData['phoneNumber'] as String,
        status: 'Pending',
      );

      try {
        await FirebaseFirestoreSource().createBooking(newBooking);
        await BookingListPageController().fetchBookings(formData['venueId'] as String);
        Get.back(result: true);
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
