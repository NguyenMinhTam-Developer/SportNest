import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../controllers/authentication_controller.dart';
import '../../../core/routes/pages.dart';
import '../../../data/models/user_model.dart';

class SignInPageController extends GetxController {
  Future<UserModel?> signInFuture = Future.value(null);

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
    try {
      if (_formKey.currentState!.saveAndValidate()) {
        signInFuture = AuthenticationController.instance.signInWithEmailAndPassword(
          _formKey.currentState!.fields['email']!.value as String,
          _formKey.currentState!.fields['password']!.value as String,
        );

        update();

        var user = await signInFuture;

        if (user != null) {
          Get.offAllNamed(Routes.home);
        }
      } else {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        LocaleKeys.alert.tr,
        LocaleKeys.email_password_incorrect.tr,
      );
    } finally {
      update();
    }
  }

  Future<void> signInWithGoogle() async {
    signInFuture = AuthenticationController.instance.signInWithGoogle();

    update();

    var user = await signInFuture;

    if (user != null) {
      Get.offAllNamed(Routes.home);
    }
  }
}

class SignInPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInPageController>(() => SignInPageController());
  }
}
