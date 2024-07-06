import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/main_component.dart';
import 'Phone Number/phone_number.dart';

image(String path) => Image.asset(path, width: 40);

heading(String text) {
  return Text(
    text,
    style: GoogleFonts.merriweather(
        color: black, fontSize: 32, fontWeight: FontWeight.w900),
  );
}

subheading(String text) {
  return Text(
    text,
    style: GoogleFonts.quicksand(color: grey, fontWeight: FontWeight.bold),
  );
}

class CTextField extends StatelessWidget {
  const CTextField({
    super.key,
    this.onTap,
    required this.controller,
    this.readOnly,
    this.textAlign,
    this.autofocus,
    this.suffixIcon,
    this.onChanged,
    this.obscureText,
    required this.hintText,
    this.keyboardType,
    this.fontSize,
  });

  final String hintText;
  final VoidCallback? onTap;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool? readOnly;
  final TextAlign? textAlign;
  final bool? autofocus;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.start,
      autofocus: autofocus ?? false,
      obscureText: obscureText ?? false,
      cursorColor: black,
      cursorHeight: fontSize != null ? (fontSize! + 10) : 30,
      keyboardType: keyboardType ?? TextInputType.text,
      style: GoogleFonts.nunito(
        fontSize: fontSize ?? 20,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold),
        suffixIcon: suffixIcon,
        suffixIconColor: black,
        suffixIconConstraints: const BoxConstraints(maxWidth: 20),
        contentPadding: const EdgeInsets.only(bottom: 0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: black),
        ),
      ),
    );
  }
}

class BottomText extends StatelessWidget {
  const BottomText({super.key, required this.text, this.onTap, this.color});

  final void Function()? onTap;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: GoogleFonts.quicksand(
          color: color ?? green,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class CElevatedButton extends StatelessWidget {
  const CElevatedButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.route,
  });

  final String text;
  final Color backgroundColor;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shadowColor: Colors.transparent,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          )),
      child: Text(
        text,
        style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: white),
      ),
    );
  }
}

authElevatedButton(context, route) {
  return ElevatedButton(
    onPressed: route,
    style: ElevatedButton.styleFrom(
      backgroundColor: green,
      shadowColor: Colors.transparent,
    ),
    child: const Icon(Icons.arrow_forward_ios_rounded, color: white),
  );
}

Future sendCode(String countryCode, String phoneNumber) async {
  try {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "$countryCode $phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? forceResendingToken) {
          PhoneNumber.verify = verificationId;
        },
        timeout: const Duration(seconds: 90),
        codeAutoRetrievalTimeout: (String verificationId) {});
  } on FirebaseAuthException catch (e) {
    print(e);
  }
}
