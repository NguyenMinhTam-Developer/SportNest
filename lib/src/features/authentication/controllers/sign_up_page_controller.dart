import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart';

import '../../../controllers/authentication_controller.dart';
import '../../../core/routes/pages.dart';

class SignUpPageController extends GetxController {
  Future<UserModel?> signUpFuture = Future.value(null);

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  bool _isAgree = false;
  bool get isAgree => _isAgree;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> get formKey => _formKey;

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  AutovalidateMode get autovalidateMode => _autovalidateMode;

  void onPasswordVisibilityPressed() {
    _obscureText = !_obscureText;
    update();
  }

  void onAgreePressed(bool? value) {
    _isAgree = value!;
    update();
  }

  Future<void> onSubmitPressed() async {
    if (_formKey.currentState!.saveAndValidate()) {
      signUpFuture = AuthenticationController.instance.signUpWithEmailAndPassword(
        email: _formKey.currentState!.fields['email']!.value as String,
        username: _formKey.currentState!.fields['username']!.value as String,
        password: _formKey.currentState!.fields['password']!.value as String,
      );

      update();

      var user = await signUpFuture;

      if (user != null) {
        Get.offAllNamed(Routes.home);
      }
    } else {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
      update();
    }
  }

  Future<void> signInWithGoogle() async {
    signUpFuture = AuthenticationController.instance.signInWithGoogle();

    update();

    var user = await signUpFuture;

    if (user != null) {
      Get.offAllNamed(Routes.home);
    }
  }
}

class SignUpPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpPageController>(() => SignUpPageController());
  }
}
