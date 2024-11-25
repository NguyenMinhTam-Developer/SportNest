import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../../../generated/locales.g.dart';

import '../../../../controllers/application_controller.dart';
import '../../../../data/models/unit_model.dart';

class UpdateUnitPageController extends GetxController {
  late UnitModel initialUnit;

  bool isLoading = false;

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

        await ApplicationController.instance.updateUnit(
          UnitModel(
            id: initialUnit.id,
            name: name,
            price: price,
            type: type,
            venueId: initialUnit.venueId,
          ),
        );

        isLoading = false;
        update();

        Get.back(result: true, closeOverlays: true);

        Get.snackbar(
          LocaleKeys.success.tr,
          LocaleKeys.unit_updated_successfully.tr,
        );
      } catch (e) {
        Get.snackbar(
          LocaleKeys.alert.tr,
          LocaleKeys.failed_to_update_unit.tr,
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
    initialUnit = Get.arguments as UnitModel;
    super.onInit();
  }
}

class UpdateUnitPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateUnitPageController>(() => UpdateUnitPageController());
  }
}
