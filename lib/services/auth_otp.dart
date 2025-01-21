import 'dart:developer';
import 'package:breedit/check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCode {
  static String verifyId = "";
  static final FirebaseAuth auth = FirebaseAuth.instance;

// MARK: Send code
  static void sendCode(
    BuildContext context,
    String countryCode,
    String phoneNumber,
  ) async {
    String? numberWithCountryCode = "$countryCode $phoneNumber";
    log(numberWithCountryCode);

    // verification completed
    void verificationCompleted(AuthCredential credential) async {
      try {
        await auth.signInWithCredential(credential);
        log("Verification Completed");
      } catch (e) {
        log("Error signing in with credential: $e");
      }
    }

    // verification exception
    void verificationFailed(FirebaseAuthException e) {
      log("Verification failed: ${e.message}");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Verification failed: ${e.message}'),
        ));
      }
    }

    // verification code sent
    void codeSent(String verificationId, int? forceResendingToken) {
      verifyId = verificationId;
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, "/otp", (_) => false);
      }
    }

    // auto code retrieval timeout
    void codeAutoRetrievalTimeout(String verificationId) {
      log("Auto-retrieval timeout for verification ID: $verificationId");
    }

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: numberWithCountryCode,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: const Duration(microseconds: 10000),
      );
    } on FirebaseException catch (e) {
      log("Firebase Exception: $e");
    } catch (e) {
      log("Exception: $e");
    }
  }

// MARK: Verify code
  static Future<void> verifyCode(
    BuildContext context,
    String smsCode,
  ) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verifyId, smsCode: smsCode);
      // UserCredential userCredential =
      await auth.signInWithCredential(credential);
      // String uid = userCredential.user!.uid;
      // bool userExist = await hasImagesInPetDocument(uid);
      if (context.mounted) {
        navigatorToScreen(context, true);
      }
      log("Phone number verified and user signed in");
    } catch (e) {
      log("Error verifying OTP: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid OTP. Please try again.'),
          ),
        );
      }
    }
  }

  static void navigatorToScreen(BuildContext context, bool userExist) {
    if (userExist) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Check(),
          ),
          (_) => false);
      // Navigator.pushNamedAndRemoveUntil(context, "/information", (_) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Check(),
          ),
          (_) => false);
      // Navigator.pushNamedAndRemoveUntil(context, "/information", (_) => false);
    }
  }
}
