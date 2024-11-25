import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../controllers/application_controller.dart';
import '../../../../core/routes/pages.dart';

import '../../../../data/models/booking_model.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../data/params/update_booking_param.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../controllers/authentication_controller.dart';
import '../../../../core/services/notification_service.dart';

class UpdateBookingPageController extends GetxController {
  BookingModel initialBooking = Get.arguments as BookingModel;

  final String _venueId = Get.parameters['venueId']!;
  final String _bookingId = Get.parameters['bookingId']!;

  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  Future<List<VenueModel>>? venues;
  Future<List<UnitModel>>? units;
  CustomerModel? customer;

  bool isLoading = false;

  @override
  Future<void> onReady() async {
    super.onReady();

    venues = FirebaseFirestoreSource().fetchVenueList(AuthenticationController.instance.currentUserModel.value!.id);
    formKey.currentState?.fields['venueId']?.didChange(initialBooking.venueId);
    formKey.currentState?.patchValue({"venueId": initialBooking.venueId});

    units = FirebaseFirestoreSource().fetchUnitList(_venueId);

    formKey.currentState?.fields['unitId']?.didChange(initialBooking.unitId);
    formKey.currentState?.patchValue({"unitId": initialBooking.unitId});

    customer = initialBooking.customer;
    formKey.currentState?.patchValue({"contactName": customer!.name});

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

      final updatedBookingParam = UpdateBookingParam(
        id: _bookingId,
        venueId: venueId,
        unitId: unitId,
        customerId: initialBooking.customerId ?? '',
        startTime: startDateTime,
        endTime: endDateTime,
        updatedBy: AuthenticationController.instance.currentUserModel.value!.id,
        updatedAt: Timestamp.now(),
      );

      try {
        final booking = await FirebaseFirestoreSource().updateBooking(updatedBookingParam);

        await ApplicationController.instance.asyncBookingData();

        await NotificationService().cancelBookingNotification(
          booking.numericId,
        );

        await NotificationService().scheduleBookingNotification(
          bookingId: booking.numericId,
          title: LocaleKeys.upcoming_booking.tr,
          body: LocaleKeys.upcoming_booking_message.trParams({"venueName": booking.venue?.name ?? ''}),
          scheduledDate: booking.startTime!.toDate().subtract(const Duration(minutes: 10)),
        );

        Get.back(result: true);
        Get.snackbar(
          LocaleKeys.success.tr,
          LocaleKeys.booking_updated_successfully.tr,
        );
      } catch (e) {
        Get.snackbar(
          LocaleKeys.alert.tr,
          LocaleKeys.failed_to_update_booking.tr,
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

  Future<void> onCustomerPressed() async {
    final result = await Get.toNamed(Routes.customers, arguments: true);

    if (result != null && result is CustomerModel) {
      customer = result;
      formKey.currentState?.patchValue({"contactName": customer!.name});
    }

    update();
  }
}

class UpdateBookingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateBookingPageController>(() => UpdateBookingPageController());
  }
}
