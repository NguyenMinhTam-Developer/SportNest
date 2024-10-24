import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../venues/presentation/controllers/venue_detail_page_controller.dart';
import '../../../venues/presentation/controllers/venue_list_page_controller.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../core/routes/pages.dart';
import '../../../../data/params/create_booking_param.dart';

import '../../../../data/models/venue_model.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../services/authentication_service.dart';

class CreateBookingPageController extends GetxController {
  final String initialVenueId = Get.parameters['venueId']!;

  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  List<VenueModel> venues = [];
  Future<List<UnitModel>>? units;

  CustomerModel? customer;

  bool isLoading = false;

  @override
  Future<void> onReady() async {
    super.onReady();

    venues = await VenueListPageController.instance.fetchVenueListFuture!;

    units = Future.value(await VenueDetailPageController.instance.fetchUnitListFuture!);

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

      final newBooking = CreateBookingParam(
        venueId: venueId,
        unitId: unitId,
        startTime: startDateTime,
        endTime: endDateTime,
        customerId: customer?.id ?? '',
        createdBy: AuthService().currentUser!.uid,
      );

      try {
        await FirebaseFirestoreSource().createBooking(newBooking);

        await VenueDetailPageController.instance.fetchBookingList(venueId);

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

  Future<void> onCustomerPressed() async {
    final result = await Get.toNamed(Routes.customers, arguments: true);

    if (result != null && result is CustomerModel) {
      customer = result;
      formKey.currentState?.patchValue({"contactName": customer!.name});
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
