import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sport_nest_flutter/generated/locales.g.dart';

import '../../../../data/models/customer_model.dart';
import '../../../../data/params/update_customer_param.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../services/authentication_service.dart';
import 'customer_detail_page_controller.dart';
import 'customer_list_page_controller.dart';

class UpdateCustomerPageController extends GetxController {
  late CustomerModel initialCustomer;
  bool isLoading = false;
  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  Future<void> onSubmitPressed() async {
    if (formKey.currentState!.saveAndValidate()) {
      String name = formKey.currentState!.fields['name']!.value as String;
      String phoneNumber = formKey.currentState!.fields['phoneNumber']!.value as String;
      String email = formKey.currentState!.fields['email']!.value as String? ?? '';
      String address = formKey.currentState!.fields['address']!.value as String? ?? '';

      try {
        isLoading = true;
        update();

        await FirebaseFirestoreSource().updateCustomer(
          UpdateCustomerParam(
            id: initialCustomer.id,
            name: name,
            phoneNumber: phoneNumber,
            email: email,
            address: address,
            updatedBy: AuthService.instance.currentUserModel!.id,
          ),
        );

        await CustomerDetailPageController.instance.fetchCustomer(initialCustomer.id);
        await CustomerListPageController.instance.fetchCustomers();

        isLoading = false;
        update();

        Get.back();

        Get.snackbar(
          LocaleKeys.success.tr,
          LocaleKeys.customerUpdatedSuccessfully.tr,
        );
      } catch (e) {
        Get.snackbar(
          LocaleKeys.alert.tr,
          LocaleKeys.failedToUpdateCustomer.tr,
        );
      }
    } else {
      autovalidateMode = AutovalidateMode.onUserInteraction;
      update();
    }
  }

  @override
  void onInit() {
    initialCustomer = Get.arguments as CustomerModel;
    super.onInit();
  }
}

class UpdateCustomerPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateCustomerPageController>(() => UpdateCustomerPageController());
  }
}
