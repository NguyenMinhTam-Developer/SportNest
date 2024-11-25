import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../../../generated/locales.g.dart';

import '../../../../data/models/unit_model.dart';
import '../../../../controllers/application_controller.dart';

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

        await ApplicationController.instance.createUnit(
          UnitModel(
            name: name,
            price: price,
            type: type,
            venueId: venueId,
          ),
        );

        isLoading = false;
        update();

        Get.back(result: true);

        Get.snackbar(
          LocaleKeys.success.tr,
          LocaleKeys.unit_created_successfully.tr,
        );
      } catch (e) {
        Get.snackbar(
          LocaleKeys.alert.tr,
          LocaleKeys.failed_to_create_unit.tr,
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
