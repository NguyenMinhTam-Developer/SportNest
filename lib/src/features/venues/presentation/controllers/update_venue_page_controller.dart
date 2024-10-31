import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sport_nest_flutter/generated/locales.g.dart';

import '../../../../data/models/venue_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../services/authentication_service.dart';
import '../../../../services/data_async_service.dart';

class UpdateVenuePageController extends GetxController {
  final String venueId = Get.parameters['venueId']!;
  final DataAsyncService dataAsyncService = DataAsyncService.instance;

  late VenueModel initialVenue;

  bool isLoading = false;

  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  Future<void> onSubmitPressed() async {
    if (formKey.currentState!.saveAndValidate()) {
      String name = formKey.currentState!.fields['name']!.value as String;
      String address = formKey.currentState!.fields['address']!.value as String;
      DateTime openTime = formKey.currentState!.fields['openTime']!.value;
      DateTime closeTime = formKey.currentState!.fields['closeTime']!.value;
      String description = formKey.currentState!.fields['description']!.value as String;

      if (!openTime.isBefore(closeTime)) {
        Get.snackbar('Alert!', 'Open time must be earlier than the close time');
        return;
      }

      try {
        isLoading = true;
        update();

        await FirebaseFirestoreSource().updateVenue(
          VenueModel(
            id: initialVenue.id,
            name: name,
            address: address,
            openTime: openTime,
            closeTime: closeTime,
            description: description,
            createdBy: AuthService.instance.currentUserModel!.id,
          ),
        );

        isLoading = false;
        update();

        await dataAsyncService.fetchVenueList();

        Get.back(result: true, closeOverlays: true);

        Get.snackbar(
          LocaleKeys.success.tr,
          LocaleKeys.venueUpdatedSuccessfully.tr,
        );
      } catch (e) {
        Get.snackbar(
          LocaleKeys.alert.tr,
          LocaleKeys.failedToUpdateVenue.tr,
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

  @override
  void onInit() {
    initialVenue = dataAsyncService.venueList.firstWhere((venue) => venue.id == venueId);
    super.onInit();
  }
}

class UpdateVenuePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateVenuePageController>(() => UpdateVenuePageController());
  }
}
