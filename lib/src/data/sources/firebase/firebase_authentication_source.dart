import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../models/user_model.dart';
import 'firebase_firestore_source.dart';

import '../../../core/errors/exceptions.dart';

class FirebaseAuthenticationSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(
        code: e.code,
        message: e.message,
      );
    }
  }

  Future<User?> signUp({required String displayName, required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      userCredential.user?.updateDisplayName(displayName.trim());

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(
        code: e.code,
        message: e.message,
      );
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential? userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // Check if user exist in Firestore
    final UserModel? user = await FirebaseFirestoreSource().fetchUser(userCredential.user?.uid ?? '');

    // If user does not exist, create new user
    if (user == null) {
      try {
        await FirebaseFirestoreSource().createUser(
          UserModel(
            id: userCredential.user?.uid ?? '',
            username: userCredential.user?.displayName ?? userCredential.user?.email ?? '',
            email: userCredential.user?.email ?? '',
          ),
        );
        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        throw AuthenticationException(
          code: e.code,
          message: e.message,
        );
      }
    }
    // If user exist, return user
    else {
      return userCredential.user;
    }
  }
}
