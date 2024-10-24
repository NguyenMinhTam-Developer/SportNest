import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../core/routes/pages.dart';
import '../../../data/models/user_model.dart';
import '../../../data/sources/firebase/firebase_authentication_source.dart';
import '../../../data/sources/firebase/firebase_firestore_source.dart';

class SignUpPageController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

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
      _isLoading = true;
      update();

      var user = await FirebaseAuthenticationSource().signUpWithEmailAndPassword(
        _formKey.currentState!.fields['email']!.value as String,
        _formKey.currentState!.fields['password']!.value as String,
      );

      if (user != null) {
        await FirebaseFirestoreSource().createUser(
          UserModel(
            id: user.uid,
            username: _formKey.currentState!.fields['username']!.value as String,
            email: user.email!,
          ),
        );

        _isLoading = false;
        update();

        Get.offAllNamed(Routes.home);
      }
    } else {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
      update();
    }
  }
}

class SignUpPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpPageController>(() => SignUpPageController());
  }
}
