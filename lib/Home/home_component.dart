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

heading(String text, Color color, double size) {
  return Text(
    text,
    style: GoogleFonts.manrope(
        fontSize: size, fontWeight: FontWeight.bold, color: color),
  );
}

subheading(String text, Color color, double size) {
  return Text(
    text,
    style: GoogleFonts.quicksand(
        fontSize: size, color: color, fontWeight: FontWeight.bold),
  );
}

offer(String text) {
  return Text(
    text,
    style: GoogleFonts.quicksand(color: black, fontWeight: FontWeight.bold),
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
  ImageCard({super.key, required this.url, this.index});

  String url;
  final int? index;
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
        image(size, widget.url),
        Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                active = !active;
              });
            },
            child: like(active),
          ),
        )
      ],
    );
  }
}

image(Size size, String url) {
  return SizedBox(
    height: size.width,
    width: size.width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: url != null
          // ? Image.network(
          //     widget.url[widget.index],
          //     fit: BoxFit.cover,
          //   )
          ? Image.asset(
              url,
              fit: BoxFit.cover,
            )
          : const Center(
              child: CircularProgressIndicator(color: green),
            ),
    ),
  );
}

class TextCard extends StatefulWidget {
  const TextCard({super.key, required this.top, required this.bottom});

  final String top;
  final String bottom;

  @override
  State<TextCard> createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        card(size, widget.top, widget.bottom),
        Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                active = !active;
              });
            },
            child: like(active),
          ),
        )
      ],
    );
  }
}

card(Size size, String top, String bottom) {
  return Container(
    width: size.width,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
    decoration: BoxDecoration(
      color: black,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        subheading(top, background, 14),
        content(bottom),
      ],
    ),
  );
}

like(bool active) {
  return CircleAvatar(
    radius: 25,
    backgroundColor: white,
    child: SvgPicture.asset(
      active ? "assets/icons/fill-heart.svg" : "assets/icons/heart.svg",
      color: active ? red : black,
      height: 30,
    ),
  );
}

content(String text) {
  return Text(
    text,
    style: GoogleFonts.merriweather(
        fontWeight: FontWeight.bold, fontSize: 40, color: background),
  );
}

stories(Size size) {
  return SizedBox(
    height: 36,
    width: size.width,
    child: ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: filter(),
      ),
    ),
  );
}

filter() {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: background,
      foregroundColor: black,
      side: BorderSide(color: black),
    ),
    child: Text(
      "Age",
      style: GoogleFonts.quicksand(color: black, fontWeight: FontWeight.bold),
    ),
  );
}
