import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../data/models/user_model.dart';

import '../core/routes/pages.dart';
import '../data/sources/firebase/firebase_firestore_source.dart';

class AuthService extends GetxController implements GetxService {
  UserModel? currentUserModel;

  bool get isSignedIn => currentUserModel != null;

  Future<AuthService> init() async {
    // Listen to Firebase Auth state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        // Fetch user data from Firestore
        try {
          currentUserModel = await FirebaseFirestoreSource().fetchUser(user.uid);
          update();
        } catch (e) {
          currentUserModel = null;
          update();
        }
      } else {
        currentUserModel = null;
        update();
      }
    });

    return this;
  }

  static AuthService get instance => Get.find<AuthService>();

  refreshUserData() async {
    currentUserModel = await FirebaseFirestoreSource().fetchUser(currentUserModel?.id ?? "");
    update();
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();

    Get.offAllNamed(Routes.signIn);
  }
}
