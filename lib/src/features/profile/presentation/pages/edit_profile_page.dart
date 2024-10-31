import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import '../controllers/edit_profile_controller.dart';
import '../../../../shared/components/button.dart';
import '../../../../shared/components/input_label.dart';
import '../../../../shared/layouts/page_loading_indicator.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (controller) => PageLoadingIndicator(
        focedLoading: controller.isLoading,
        scaffold: Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
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
                    labelText: 'Email',
                    child: FormBuilderTextField(
                      name: 'email',
                      enabled: false,
                      initialValue: controller.initialUser.email,
                      decoration: const InputDecoration(
                        hintText: 'Your email',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InputLabel(
                    labelText: 'Username',
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: 'username',
                      initialValue: controller.initialUser.username,
                      decoration: const InputDecoration(
                        hintText: 'Enter your username',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(3),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InputLabel(
                    labelText: 'Phone Number',
                    child: FormBuilderTextField(
                      name: 'phoneNumber',
                      initialValue: controller.initialUser.phoneNumber,
                      decoration: const InputDecoration(
                        hintText: 'Enter your phone number',
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ButtonComponent.primary(
                    onPressed: controller.updateProfile,
                    label: 'Save Changes',
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
