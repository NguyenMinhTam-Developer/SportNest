import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../data/models/user_model.dart';

import '../core/routes/pages.dart';
import '../data/sources/firebase/firebase_firestore_source.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController get instance => Get.find<AuthenticationController>();

  UserModel? currentUserModel;

  Future<UserModel?> checkAuthState() async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      currentUserModel = await FirebaseFirestoreSource().fetchUser(user.uid);
    } else {
      currentUserModel = null;
    }

    update();

    return currentUserModel;
  }

  Future<UserModel?> updateUserData() async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      currentUserModel = await FirebaseFirestoreSource().fetchUser(user.uid);
    } else {
      currentUserModel = null;
    }

    update();

    return currentUserModel;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();

    Get.offAllNamed(Routes.signIn);
  }
}
