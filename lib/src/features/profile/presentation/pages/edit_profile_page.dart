import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../shared/components/button.dart';
import '../../../../shared/components/input_label.dart';
import '../../../../shared/layouts/page_loading_indicator.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (controller) => PageLoadingIndicator(
        focedLoading: controller.isLoading,
        scaffold: Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.edit_profile.tr),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: FormBuilder(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputLabel(
                    labelText: LocaleKeys.username.tr,
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: 'username',
                      initialValue: controller.initialUser.username,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.enter_your_username.tr,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(3),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InputLabel(
                    labelText: LocaleKeys.email.tr,
                    child: FormBuilderTextField(
                      name: 'email',
                      enabled: false,
                      initialValue: controller.initialUser.email,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.enter_your_email.tr,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InputLabel(
                    labelText: LocaleKeys.phone_number.tr,
                    child: FormBuilderTextField(
                      name: 'phoneNumber',
                      initialValue: controller.initialUser.phoneNumber,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.enter_phone_number.tr,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ButtonComponent.primary(
                    onPressed: controller.updateProfile,
                    label: LocaleKeys.save_changes.tr,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
