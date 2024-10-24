import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../data/models/customer_model.dart';
import '../../../../data/params/create_customer_param.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../services/authentication_service.dart';
import '../../../../shared/extensions/hardcode.dart';

class CreateCustomerPageController extends GetxController {
  Future<CustomerModel>? createCustomerFuture;
  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  Future<void> onSubmitPressed() async {
    if (formKey.currentState!.saveAndValidate()) {
      String name = formKey.currentState!.fields['name']!.value as String;
      String phoneNumber = formKey.currentState!.fields['phoneNumber']!.value as String;
      String email = formKey.currentState!.fields['email']!.value as String? ?? '';
      String address = formKey.currentState!.fields['address']!.value as String? ?? '';

      try {
        createCustomerFuture = FirebaseFirestoreSource().createCustomer(
          CreateCustomerParam(
            name: name,
            phoneNumber: phoneNumber,
            email: email,
            address: address,
            createdBy: AuthService.instance.currentUser!.uid,
          ),
        );

        await createCustomerFuture;

        Get.back(result: true);

        Get.snackbar(
          'Success!'.isHardcoded,
          'Customer created successfully'.isHardcoded,
        );

        update();
      } catch (e) {
        Get.snackbar(
          'Alert!'.isHardcoded,
          'Failed to create customer'.isHardcoded,
        );
      }
    } else {
      autovalidateMode = AutovalidateMode.onUserInteraction;
      update();
    }
  }
}

class CreateCustomerPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateCustomerPageController>(() => CreateCustomerPageController());
  }
}
