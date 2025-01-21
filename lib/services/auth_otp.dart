import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpService {
  static String _verifyId = "";
  static final FirebaseAuth _auth = FirebaseAuth.instance;

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
        await _auth.signInWithCredential(credential);
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
      _verifyId = verificationId;
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, "/otp", (_) => false);
      }
    }

    // auto code retrieval timeout
    void codeAutoRetrievalTimeout(String verificationId) {
      log("Auto-retrieval timeout for verification ID: $verificationId");
    }

    try {
      await _auth.verifyPhoneNumber(
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

// MARK: Verify
  static Future<void> verifyCode(
    BuildContext context,
    String smsCode,
  ) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verifyId, smsCode: smsCode);
      await _auth.signInWithCredential(credential);
      bool userExist = true;
      if (context.mounted) {
        navigatorToScreen(context, userExist);
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
      Navigator.pushNamedAndRemoveUntil(context, "/information", (_) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, "/onboarding", (_) => false);
    }
  }
}
