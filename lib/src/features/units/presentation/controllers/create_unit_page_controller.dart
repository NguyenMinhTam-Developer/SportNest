import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../data/models/unit_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../shared/extensions/hardcode.dart';
import 'unit_list_page_controller.dart';

class CreateUnitPageController extends GetxController {
  bool isLoading = false;
  String venueId = Get.parameters['venueId']!;
  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  Future<void> onSubmitPressed() async {
    if (formKey.currentState!.saveAndValidate()) {
      String name = formKey.currentState!.fields['name']!.value as String;
      double price = double.parse(formKey.currentState!.fields['price']!.value);
      String type = formKey.currentState!.fields['type']!.value as String;

      try {
        isLoading = true;
        update();

        await FirebaseFirestoreSource().createUnit(
          UnitModel(
            name: name,
            price: price,
            type: type,
            venueId: venueId,
          ),
        );

        await UnitListPageController.instance.fetchUnits(venueId);

        isLoading = false;
        update();

        Get.back();

        Get.snackbar(
          'Success!'.isHardcoded,
          'Unit created successfully'.isHardcoded,
        );
      } catch (e) {
        Get.snackbar(
          'Alert!'.isHardcoded,
          'Failed to create unit'.isHardcoded,
        );
      }
    } else {
      autovalidateMode = AutovalidateMode.onUserInteraction;
      update();
    }
  }
}

class CreateUnitPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateUnitPageController>(() => CreateUnitPageController());
  }
}
