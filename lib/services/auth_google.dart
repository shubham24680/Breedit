import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await _auth.signInWithCredential(credential);
      bool userExist = true;
      if (context.mounted) {
        navigatorToScreen(context, userExist);
      }
      log("Phone number verified and user signed in");
    } on FirebaseException catch (e) {
      log("Firebase Exception: $e");
    } catch (e) {
      log("Exception: $e");
    }
  }

  static void navigatorToScreen(BuildContext context, bool userExist) {
    if (userExist) {
      Navigator.pushNamedAndRemoveUntil(context, "/information", (_) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, "/onboarding", (_) => false);
    }
  }
}
