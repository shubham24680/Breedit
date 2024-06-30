import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';

import '../main_component.dart';
import 'auth_component.dart';
import 'create_account.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen(this.countryCode, this.phoneNumber, {super.key});

  final String countryCode;
  final String phoneNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool active = false;
  bool onPressedValue = true;
  String code = "";

  pinTheme(double opacity) {
    return PinTheme(
      height: 56,
      width: 56,
      textStyle: GoogleFonts.nunito(
          color: black, fontWeight: FontWeight.bold, fontSize: 24),
      decoration: BoxDecoration(
        color: green.withOpacity(opacity),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Future<void> getVerified() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: CreateAccount.verify, smsCode: code);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      String uid = userCredential.user!.uid;
      bool hasImage = await hasImagesInPetDocument(uid);
      navigateToScreen(hasImage);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        print('Invalid OTP entered');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid OTP. Please enter a valid OTP.'),
          ),
        );
      } else {
        print("Firebase Authentication Error: ${e.message}");
      }
    }
  }

  Future<bool> hasImagesInPetDocument(String uid) async {
    try {
      final ref =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      return ref.exists;
    } catch (e) {
      print("Error retrieving pet document: $e");
      return false;
    }
  }

  void navigateToScreen(bool hasImage) {
    if (hasImage) {
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, 'userInfo', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // IMAGE
                  image("assets/icons/shield.png"),
                  const SizedBox(height: 20),

                  // HEADING
                  heading("Enter your verification code"),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      // SUBHEADING
                      subheading(
                          "Sent to ${widget.countryCode} ${widget.phoneNumber}."),
                      const SizedBox(width: 10),
                      BottomText(
                          onTap: () => Navigator.pushNamedAndRemoveUntil(
                              context, 'createAccount', (route) => false),
                          text: "Edit"),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // OTP INPUT AREA
                  Pinput(
                    length: 6,
                    showCursor: false,
                    onChanged: (value) {
                      setState(() {
                        code = value;
                        active = value.length == 6;
                      });
                    },
                    defaultPinTheme: pinTheme(0.1),
                    focusedPinTheme: pinTheme(0.4),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // RESEND CODE
                  BottomText(
                    onTap: onPressedValue
                        ? () {
                            setState(() {
                              onPressedValue = false;
                              sendCode(widget.countryCode, widget.phoneNumber);
                            });
                            Timer(const Duration(seconds: 30), () {
                              setState(() {
                                onPressedValue = true;
                              });
                            });
                          }
                        : null,
                    text: "Didn't get a code?",
                    color: onPressedValue ? null : Colors.grey.shade400,
                  ),

                  // NAVIGATON BUTTON
                  authElevatedButton(
                    context,
                    active
                        ? () {
                            getVerified();
                          }
                        : null,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
