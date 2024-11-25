import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../controllers/application_controller.dart';
import '../../../../shared/extensions/x_datetime.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../core/routes/pages.dart';
import '../../../../data/params/create_booking_param.dart';

import '../../../../data/models/unit_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../controllers/authentication_controller.dart';
import '../../../../core/services/notification_service.dart';

class CreateBookingPageController extends GetxController {
  final String initialVenueId = Get.parameters['venueId']!;

  List<VenueModel> venues = [];

  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  List<UnitModel> units = [];

  CustomerModel? customer;

  bool isLoading = false;
  bool isWalkInCustomer = false;

  @override
  Future<void> onReady() async {
    super.onReady();

    venues = ApplicationController.instance.venueList.value;

    units = venues.firstWhere((v) => v.id == initialVenueId).unitList;

    update();
  }

  Future<void> onVenueChanged(String? value) async {
    if (value == null) return;

    formKey.currentState?.patchValue({"unitId": null});

    units = venues.firstWhere((v) => v.id == value).unitList;

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
      final price = units.firstWhere((u) => u.id == unitId).price;

      final startDateTime = Timestamp.fromDate(DateTime(
        date.year,
        date.month,
        date.day,
        startTime.hour,
        startTime.minute,
      ));
      final endDateTime = Timestamp.fromDate(DateTime(
        date.year,
        date.month,
        date.day,
        endTime.hour,
        endTime.minute,
      ));

      final newBooking = CreateBookingParam(
        venueId: venueId,
        unitId: unitId,
        startTime: startDateTime,
        endTime: endDateTime,
        price: price,
        customerId: customer?.id,
        createdBy: AuthenticationController.instance.currentUserModel.value!.id,
      );

      try {
        var data = await FirebaseFirestoreSource().createBooking(newBooking);

        await ApplicationController.instance.asyncBookingData();

        // Only schedule notification if booking is in the future
        final bookingDateTime = newBooking.startTime.toDate();

        if (bookingDateTime.isAfter(DateTime.now())) {
          await NotificationService().scheduleBookingNotification(
            bookingId: data.numericId,
            title: 'Upcoming Booking',
            body: 'Your booking at ${venues.firstWhere((v) => v.id == venueId).name} is scheduled for ${newBooking.startTime.toDate().formatDate()}',
            scheduledDate: bookingDateTime.subtract(const Duration(minutes: 10)), // Notify 10 minutes before
          );
        }

        Get.back(result: true);

        Get.snackbar('Success', 'Booking created successfully');
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

  Future<void> onCustomerPressed() async {
    final result = await Get.toNamed(Routes.customers, arguments: true);

    if (result != null && result is CustomerModel) {
      customer = result;
      formKey.currentState?.patchValue({"contactName": customer!.name});
    }

    update();
  }

  void onWalkInCustomerChanged(bool? value) {
    isWalkInCustomer = value ?? false;
    if (isWalkInCustomer) {
      customer = null;
      formKey.currentState?.patchValue({"contactName": null});
    }

    update();
  }
}

class CreateBookingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateBookingPageController>(() => CreateBookingPageController());
  }
}
