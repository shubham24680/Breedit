import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main_component.dart';
import '../permissions.dart';

// MARK: GET DATA
// ignore: prefer_typing_uninitialized_variables
var data;
User? user = FirebaseAuth.instance.currentUser;
Future<void> getData(String collection) async {
  DocumentReference document =
      FirebaseFirestore.instance.collection(collection).doc(user!.uid);
  DocumentSnapshot snapshot = await document.get();
  data = snapshot.data() as Map<String, dynamic>;
}

// MARK: CRATE DATA
Future<void> create(String collection, Map<String, dynamic> data) async {
  try {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(user!.uid)
        .set(data);
    print('User data added/updated successfully!');
  } catch (e) {
    print('Error adding/updating user data: $e');
  }
}

// MARK: UPDATE DATA
Future<void> update(String collection, Map<String, dynamic> data) async {
  try {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(user!.uid)
        .update(data);
    print('User data added/updated successfully!');
  } catch (e) {
    print('Error adding/updating user data: $e');
  }
}

// MARK: HEADING
heading(String text, Color color, double size) {
  return Text(
    text,
    style: GoogleFonts.manrope(
        fontSize: size, fontWeight: FontWeight.bold, color: color),
  );
}

h2(String text, Color color, double size) {
  return Text(
    text,
    style: GoogleFonts.quicksand(
        fontSize: size, color: color, fontWeight: FontWeight.bold),
  );
}

// MARK: STORIES
class Stories extends StatefulWidget {
  const Stories({super.key});

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  List<List<dynamic>> storyStatus = [
    ["Age", false],
    ["Height", false],
    ["Breed", false],
    ["Male", false],
    ["Female", false],
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: 36,
      width: size.width,
      child: ListView.builder(
        itemCount: storyStatus.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  storyStatus[index][1] = !storyStatus[index][1];
                });
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: black,
                backgroundColor: storyStatus[index][1] ? black : background,
                side: BorderSide(color: black),
              ),
              child: h2("${storyStatus[index][0]}",
                  storyStatus[index][1] ? background : black, 14)),
        ),
      ),
    );
  }
}

// MARK: IMAGES
image(Size size, String url) {
  return SizedBox(
    height: size.width,
    width: size.width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
    ),
  );
}

like(bool active) {
  return CircleAvatar(
    radius: 25,
    backgroundColor: white,
    child: SvgPicture.asset(
      active ? "assets/icons/fill-heart.svg" : "assets/icons/heart.svg",
      colorFilter: ColorFilter.mode(active ? red : black, BlendMode.srcIn),
      height: 30,
    ),
  );
}

// ignore: must_be_immutable
class ImageCard extends StatefulWidget {
  ImageCard({super.key, required this.url});

  String url;

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
        h2(top, background, 14),
        content(bottom),
      ],
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

// MARK: PET PROFILE PIC
class PetProfilePhoto extends StatefulWidget {
  const PetProfilePhoto({
    super.key,
    required this.height,
    required this.crossAxisCount,
    required this.item,
    required this.collection,
  });

  final double height;
  final int crossAxisCount;
  final List<String?> item;
  final String collection;

  @override
  State<PetProfilePhoto> createState() => _PetProfilePhotoState();
}

class _PetProfilePhotoState extends State<PetProfilePhoto> {
  Future<void> refreshMate() async {
    await getData(widget.collection);
    if (mounted) {
      setState(() {
        for (int i = 0; i < data['images'].length; i++) {
          widget.item[i] = data['images'][i];
        }
      });
    }
  }

  Future<void> pickImage(int index) async {
    try {
      if (await checkPermission()) {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;

        final imagePath = File(image.path);
        await _uploadImages(index, imagePath);
      }
    } on PlatformException catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _uploadImages(int index, File imagePath) async {
    firebase_storage.Reference ref;
    if (widget.item[index] == null) {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('mate/$imageName.jpg');
    } else {
      update(widget.collection, {
        'images': FieldValue.arrayRemove([widget.item[index]])
      });
      ref = firebase_storage.FirebaseStorage.instance
          .refFromURL(widget.item[index]!);
      widget.item[index] = null;
    }

    firebase_storage.UploadTask uploadTask = ref.putFile(imagePath);
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
    String dowloadUrl = await taskSnapshot.ref.getDownloadURL();
    update(widget.collection, {
      'images': FieldValue.arrayUnion([dowloadUrl])
    });
    refreshMate();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: GridView.builder(
        itemCount: widget.item.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => pickImage(index),
          child: Container(
            decoration: BoxDecoration(
              color: background,
              border: Border.all(color: black),
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: widget.item[index] != null
                    ? NetworkImage(widget.item[index]!) as ImageProvider
                    : const AssetImage('assets/pictures/add.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

UrlLauncher(String url) async {
  Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception("Could not launch $uri");
  }
}

offer(String text) {
  return Text(
    text,
    style: GoogleFonts.quicksand(color: black, fontWeight: FontWeight.bold),
  );
}

content(String text) {
  return Text(
    text,
    style: GoogleFonts.merriweather(
        fontWeight: FontWeight.bold, fontSize: 40, color: background),
  );
}

questions(String text) {
  return Text(
    text,
    style: GoogleFonts.merriweather(
        color: black, fontSize: 24, fontWeight: FontWeight.w900),
  );
}
