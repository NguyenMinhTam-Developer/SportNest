import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../../services/authentication_service.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import 'venue_list_page_controller.dart';
import '../../../../shared/extensions/hardcode.dart';

class CreateVenuePageController extends GetxController {
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

        await FirebaseFirestoreSource().createVenue(
          VenueModel(
            name: name,
            address: address,
            openTime: openTime,
            closeTime: closeTime,
            description: description,
            createdBy: AuthService.instance.user!.uid,
          ),
        );

        await VenueListPageController.instance.fetchVenues();

        isLoading = false;
        update();

        Get.back();

        Get.snackbar(
          'Success!'.isHardcoded,
          'Venue created successfully'.isHardcoded,
        );
      } catch (e) {
        Get.snackbar(
          'Alert!'.isHardcoded,
          'Failed to create venue'.isHardcoded,
        );
      }
    } else {
      autovalidateMode = AutovalidateMode.onUserInteraction;
      update();
    }
  }
}

class CreateVenuePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateVenuePageController>(() => CreateVenuePageController());
  }
}
