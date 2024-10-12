import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import 'unit_detail_page_controller.dart';
import 'unit_list_page_controller.dart';
import '../../../../shared/extensions/hardcode.dart';

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

        await FirebaseFirestoreSource().updateUnit(
          UnitModel(
            id: initialUnit.id,
            name: name,
            price: price,
            type: type,
            venueId: initialUnit.venueId,
          ),
        );

        await UnitDetailPageController.instance.fetchUnit(initialUnit.id);

        await UnitListPageController.instance.fetchUnits(initialUnit.venueId);

        isLoading = false;
        update();

        Get.back();

        Get.snackbar(
          'Success!'.isHardcoded,
          'Unit updated successfully'.isHardcoded,
        );
      } catch (e) {
        Get.snackbar(
          'Alert!'.isHardcoded,
          'Failed to update unit'.isHardcoded,
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
