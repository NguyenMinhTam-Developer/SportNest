import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../generated/locales.g.dart';
import '../data/sources/firebase/firebase_authentication_source.dart';
import '../data/models/user_model.dart';

import '../core/routes/pages.dart';
import '../data/sources/firebase/firebase_firestore_source.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController get instance => Get.find<AuthenticationController>();

  Rx<UserModel?> currentUserModel = Rx(null);

  RxBool isLoading = RxBool(false);

  Future<UserModel?> checkAuthState() async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      currentUserModel.value = await FirebaseFirestoreSource().fetchUser(user.uid);
    } else {
      currentUserModel.value = null;
    }

    update();

    return currentUserModel.value;
  }

  Future<UserModel?> updateUserData() async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      currentUserModel.value = await FirebaseFirestoreSource().fetchUser(user.uid);
    } else {
      currentUserModel.value = null;
    }

    return currentUserModel.value;
  }

  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;

      var userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      var user = await FirebaseFirestoreSource().fetchUser(userCredential.user!.uid);

      if (user != null) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar(
        LocaleKeys.alert.tr,
        LocaleKeys.email_password_incorrect.tr,
      );

      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<UserModel?> signUpWithEmailAndPassword({required String email, required String username, required String password}) async {
    try {
      isLoading.value = true;

      var user = await FirebaseAuthenticationSource().signUp(
        displayName: username,
        email: email,
        password: password,
      );

      if (user != null) {
        return await FirebaseFirestoreSource().createUser(UserModel(id: user.uid, username: username, email: email)).then((value) {
          return value;
        });
      } else {
        Get.snackbar(
          LocaleKeys.alert.tr,
          LocaleKeys.sign_up_failed.tr,
        );

        return null;
      }
    } catch (e) {
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      isLoading.value = true;
      var user = await FirebaseAuthenticationSource().signInWithGoogle();

      if (user != null) {
        return await FirebaseFirestoreSource().fetchUser(user.uid);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar(
        LocaleKeys.alert.tr,
        LocaleKeys.sign_in_with_google_error_msg.tr,
      );

      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();

    currentUserModel.value = null;

    Get.offAllNamed(Routes.signIn);
  }

  @override
  void onInit() {
    super.onInit();

    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user != null) {
        updateUserData();
      } else {
        currentUserModel.value = null;
      }
    });
  }
}
