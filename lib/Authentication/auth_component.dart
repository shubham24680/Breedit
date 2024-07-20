import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '/main_component.dart';
import 'Phone Number/phone_number.dart';

image(String path) => Image.asset(path, width: 40);

heading(String text) {
  return Text(
    text,
    style: GoogleFonts.merriweather(
        color: black, fontSize: 28, fontWeight: FontWeight.w900),
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
    this.hintText,
  });

  final TextEditingController controller;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final bool? readOnly;
  final TextAlign? textAlign;
  final bool? autofocus;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? obscureText;

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
      cursorHeight: 43,
      keyboardType: TextInputType.phone,
      style: GoogleFonts.manrope(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.manrope(
          fontSize: 28,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
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

subheading(String text) {
  return Text(
    text,
    style: GoogleFonts.quicksand(color: grey, fontWeight: FontWeight.bold),
  );
}

launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception("Could not launch $uri");
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

authElevatedButton(context, route) {
  return ElevatedButton(
    onPressed: route,
    style: ElevatedButton.styleFrom(
      foregroundColor: white,
      backgroundColor: green,
      shadowColor: Colors.transparent,
    ),
    child: const Icon(Icons.arrow_forward_ios_rounded, color: white),
  );
}

// class CElevatedButton extends StatelessWidget {
//   const CElevatedButton({
//     super.key,
//     required this.text,
//     required this.backgroundColor,
//     required this.route,
//   });

//   final String text;
//   final Color backgroundColor;
//   final String route;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () => Navigator.pushNamed(context, route),
//       style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor,
//           shadowColor: Colors.transparent,
//           minimumSize: const Size.fromHeight(50),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(25),
//           )),
//       child: Text(
//         text,
//         style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: white),
//       ),
//     );
//   }
// }

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
