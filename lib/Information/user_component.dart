import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_component.dart';

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
    style: GoogleFonts.quicksand(
        color: Colors.grey.shade400, fontWeight: FontWeight.bold),
  );
}

class CTextField extends StatelessWidget {
  const CTextField({
    super.key,
    required this.controller,
    this.onTap,
    this.autofocus,
    required this.hintText,
    this.onChanged,
    this.readOnly,
  });

  final TextEditingController controller;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final bool? autofocus;
  final bool? readOnly;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
      cursorColor: black,
      cursorHeight: 40,
      style: GoogleFonts.nunito(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.nunito(
          fontSize: 30,
          color: grey,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
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

longButton(context, String newRouteName, String text) {
  return ElevatedButton(
    onPressed: () => Navigator.pushNamedAndRemoveUntil(
        context, newRouteName, (route) => false),
    style: ElevatedButton.styleFrom(
        backgroundColor: green,
        shadowColor: Colors.transparent,
        minimumSize: const Size.fromHeight(60),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)))),
    child: Text(
      text,
      style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: white),
    ),
  );
}

final CollectionReference ref = FirebaseFirestore.instance.collection('users');
final FirebaseAuth auth = FirebaseAuth.instance;
final user = auth.currentUser;

Future<void> create(
    String firstName, String lastName, String dob, String gender) async {
  try {
    await ref.doc(user!.uid).set({
      'first name': firstName,
      'last name': lastName,
      'date of birth': dob,
      'gender': gender,
    });
    print('User data added/updated successfully!');
  } catch (e) {
    print('Error adding/updating user data: $e');
  }
}

Future<void> update(String x, String y) async {
  try {
    await ref.doc(user!.uid).update({x: y});
    print('User data added/updated successfully!');
  } catch (e) {
    print('Error adding/updating user data: $e');
  }
}

// Future<void> petCreate(String pet) async {
//   try {
//     await ref.doc(user!.uid).collection('pet').doc(user!.uid).set({'pet': pet});
//     print('User data added/updated successfully!');
//   } catch (e) {
//     print('Error adding/updating user data: $e');
//   }
// }

// Future<void> petUpdate(String x, var y) async {
//   try {
//     await ref.doc(user!.uid).collection('pet').doc(user!.uid).update({x: y});
//     print('User data added/updated successfully!');
//   } catch (e) {
//     print('Error adding/updating user data: $e');
//   }
// }
