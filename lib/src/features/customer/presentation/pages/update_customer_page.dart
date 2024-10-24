import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../core/design/shadow.dart';
import '../../../../shared/components/button.dart';
import '../../../../shared/components/input_label.dart';
import '../../../../shared/extensions/hardcode.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../../../../shared/layouts/page_loading_indicator.dart';
import '../controllers/update_customer_page_controller.dart';

class UpdateCustomerPage extends GetView<UpdateCustomerPageController> {
  const UpdateCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateCustomerPageController>(builder: (controller) {
      return PageLoadingIndicator(
        focedLoading: controller.isLoading,
        scaffold: Scaffold(
          appBar: AppBar(title: Text('Update Customer'.isHardcoded)),
          body: SingleChildScrollView(
            clipBehavior: Clip.none,
            padding: EdgeInsets.all(16.w),
            child: FormBuilder(
              key: controller.formKey,
              autovalidateMode: controller.autovalidateMode,
              child: EKAutoLayout(
                gap: 16.h,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputLabel(
                    labelText: "Name".isHardcoded,
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: "name",
                      initialValue: controller.initialCustomer.name,
                      decoration: InputDecoration(
                        hintText: "Enter customer name".isHardcoded,
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ),
                  InputLabel(
                    labelText: "Phone Number".isHardcoded,
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: "phoneNumber",
                      initialValue: controller.initialCustomer.phoneNumber,
                      decoration: InputDecoration(
                        hintText: "Enter phone number".isHardcoded,
                      ),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                  ),
                  InputLabel(
                    labelText: "Email".isHardcoded,
                    child: FormBuilderTextField(
                      name: "email",
                      initialValue: controller.initialCustomer.email,
                      decoration: InputDecoration(
                        hintText: "Enter email address".isHardcoded,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.email(),
                      ]),
                    ),
                  ),
                  InputLabel(
                    labelText: "Address".isHardcoded,
                    child: FormBuilderTextField(
                      name: "address",
                      initialValue: controller.initialCustomer.address,
                      decoration: InputDecoration(
                        hintText: "Enter address".isHardcoded,
                      ),
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.done,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              boxShadow: [
                AppShadow.dropShadow,
              ],
            ),
            child: SafeArea(
              child: ButtonComponent.primary(
                onPressed: controller.onSubmitPressed,
                label: "Update Customer".isHardcoded,
              ),
            ),
          ),
        ),
      );
    });
  }
}
