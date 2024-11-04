import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../../data/models/user_model.dart';
import '../../../../controllers/authentication_controller.dart';

import '../../../../data/sources/firebase/firebase_firestore_source.dart';

class EditProfileController extends GetxController {
  final _authService = AuthenticationController.instance;
  final formKey = GlobalKey<FormBuilderState>();

  late final UserModel initialUser;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    initialUser = _authService.currentUserModel!;
  }

  Future<void> updateProfile() async {
    if (!(formKey.currentState?.saveAndValidate() ?? false)) return;

    try {
      isLoading = true;
      update();

      final formData = formKey.currentState!.value;
      final updatedUser = UserModel(
        id: initialUser.id,
        username: formData['username'] as String,
        email: initialUser.email,
        phoneNumber: formData['phoneNumber'] as String? ?? '',
      );

      await FirebaseFirestoreSource().updateUser(updatedUser);
      await _authService.updateUserData();

      Get.back(closeOverlays: true);
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}
