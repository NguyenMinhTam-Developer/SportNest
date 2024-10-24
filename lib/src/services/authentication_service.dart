// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  User? get currentUser => FirebaseAuth.instance.currentUser;

  bool get isSignedIn => currentUser != null;

  Future<AuthService> init() async {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    return this;
  }

  static AuthService get instance => Get.find<AuthService>();
}
