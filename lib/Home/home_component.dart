import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_component.dart';

heading(String text) {
  return Text(
    text,
    style: GoogleFonts.manrope(
        fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey.shade900),
  );
}

// ignore: prefer_typing_uninitialized_variables
var data, petData;
String uid = FirebaseAuth.instance.currentUser!.uid;
CollectionReference ref = FirebaseFirestore.instance.collection('users');
Future<void> getData() async {
  DocumentReference document = ref.doc(uid);
  DocumentSnapshot snapshot = await document.get();
  DocumentSnapshot petSnapshot =
      await document.collection('pet').doc(uid).get();
  data = snapshot.data() as Map<String, dynamic>;
  petData = petSnapshot.data() as Map<String, dynamic>;
}
