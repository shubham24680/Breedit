import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main_component.dart';

UrlLauncher(String url) async {
  Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception("Could not launch $uri");
  }
}

heading(String text) {
  return Text(
    text,
    style: GoogleFonts.manrope(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.grey.shade900),
  );
}

subheading(String text) {
  return Text(
    text,
    style: GoogleFonts.quicksand(
        fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
  );
}

offer(String text) {
  return Text(
    text,
    style: GoogleFonts.quicksand(color: black,  fontWeight: FontWeight.bold),
  );
}

// ignore: prefer_typing_uninitialized_variables
var data, petData;
User? user = FirebaseAuth.instance.currentUser;
CollectionReference ref = FirebaseFirestore.instance.collection('users');
Future<void> getData() async {
  DocumentReference document = ref.doc(user!.uid);
  DocumentSnapshot snapshot = await document.get();
  // DocumentSnapshot petSnapshot =
  //     await document.collection('pet').doc(user!.uid).get();
  data = snapshot.data() as Map<String, dynamic>;
  // petData = petSnapshot.data() as Map<String, dynamic>;
}

Future<void> update(String x, String y) async {
  try {
    await ref.doc(user!.uid).update({x: y});
    print('User data added/updated successfully!');
  } catch (e) {
    print('Error adding/updating user data: $e');
  }
}

// ignore: must_be_immutable
class ImageCard extends StatefulWidget {
  ImageCard({super.key, required this.url, required this.index});

  var url;
  final int index;
  // static bool active = false;

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SizedBox(
          height: size.width,
          width: size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: widget.url != null
                ? Image.network(
                    widget.url[widget.index],
                    fit: BoxFit.cover,
                  )
                : const Center(
                    child: CircularProgressIndicator(color: green),
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                active = !active;
              });
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: white,
              child: SvgPicture.asset(
                active
                    ? "assets/icons/fill-heart.svg"
                    : "assets/icons/heart.svg",
                color: active ? red : black,
                height: 30,
              ),
            ),
          ),
        )
      ],
    );
  }
}
