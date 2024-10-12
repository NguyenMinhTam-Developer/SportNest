import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/routes/pages.dart';
import '../../../data/sources/firebase/firebase_authentication_source.dart';

class SignInPageController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> get formKey => _formKey;

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  AutovalidateMode get autovalidateMode => _autovalidateMode;

  void onPasswordVisibilityPressed() {
    _obscureText = !_obscureText;
    update();
  }

  Future<void> onSubmitPressed() async {
    if (_formKey.currentState!.saveAndValidate()) {
      try {
        _isLoading = true;
        update();

        await FirebaseAuthenticationSource().signInWithEmailAndPassword(
          _formKey.currentState!.fields['email']!.value as String,
          _formKey.currentState!.fields['password']!.value as String,
        );

        Get.offAllNamed(Routes.home);
      } on AuthenticationException {
        Get.snackbar("Alert!", "Email or password is incorrect");
      } finally {
        _isLoading = false;
        update();
      }
    } else {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
      update();
    }
  }
}

class SignInPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInPageController>(() => SignInPageController());
  }
}
