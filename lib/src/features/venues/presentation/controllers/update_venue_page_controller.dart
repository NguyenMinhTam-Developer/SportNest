import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../data/models/venue_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../services/authentication_service.dart';
import '../../../../shared/extensions/hardcode.dart';
import 'venue_detail_page_controller.dart';
import 'venue_list_page_controller.dart';

class UpdateVenuePageController extends GetxController {
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
            createdBy: AuthService.instance.currentUser!.uid,
          ),
        );

        await VenueDetailPageController.instance.fetchVenue(initialVenue.id);

        await VenueListPageController.instance.fetchVenues();

        isLoading = false;
        update();

        Get.back(result: true, closeOverlays: true);

        Get.snackbar(
          'Success!'.isHardcoded,
          'Venue updated successfully'.isHardcoded,
        );
      } catch (e) {
        Get.snackbar(
          'Alert!'.isHardcoded,
          'Failed to update venue'.isHardcoded,
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
    initialVenue = Get.arguments as VenueModel;
    super.onInit();
  }
}

class UpdateVenuePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateVenuePageController>(() => UpdateVenuePageController());
  }
}
