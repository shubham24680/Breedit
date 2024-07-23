import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '/main_component.dart';
import '../home_component.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int select = 0;
  String name = "";
  final List<String?> _selected = List<String?>.generate(4, (index) => null);
  List<String> variable = ["Name", "Date of birth", "Gender"];
  List<String> value = List<String>.generate(3, (index) => "");
  List<String> petVariable = [
    "Pet type",
    "Name",
    "Date of birth",
    "Gender",
    "Breed"
  ];
  List<String> petValue = List<String>.generate(5, (index) => "");

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        name = data['first name'] + " " + data['last name'];
        value[0] = name;
        value[1] = data['dob'];
        value[2] = data['gender'];
        // petValue[0] = petData['pet'];
        // petValue[1] = petData['name'];
        // petValue[2] = petData['dob'];
        // petValue[3] = petData['gender'];
        // petValue[4] = petData['breed'];
        // var url = List.from(petData['images']);
        // for (int i = 0; i < url.length; i++) {
        //   _selected[i] = url[i];
        // }
      });
    }
  }

  Future pickImage(int index) async {
    try {
      if (_selected[index] != null) {
        final String uid = FirebaseAuth.instance.currentUser!.uid;
        final DocumentReference docRef = FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('pet')
            .doc(uid);
        docRef.update({
          'images': FieldValue.arrayRemove([_selected[index]])
        });
      }

      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imagePath = File(image.path);
      await _uploadImages(imagePath);
      await getData('users');
      if (mounted) {
        setState(() {
          name = data['first name'] + " " + data['last name'];
          // var url = List.from(petData['images']);
          // for (int i = 0; i < url.length; i++) {
          //   _selected[i] = url[i];
          // }
        });
      }
    } on PlatformException catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _uploadImages(imagePath) async {
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('image/$imageName.jpg');
    firebase_storage.UploadTask uploadTask = ref.putFile(imagePath);
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
    String dowloadUrl = await taskSnapshot.ref.getDownloadURL();
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final DocumentReference docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('pet')
        .doc(uid);
    docRef.update({
      'images': FieldValue.arrayUnion([dowloadUrl])
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: white),
        ),
        backgroundColor: green,
        title: Text(
          name,
          style: GoogleFonts.quicksand(
              fontSize: 20, color: white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              h2("Pet photos", grey, 18),
              const SizedBox(height: 10),

              // PHOTO SELECTION
              SizedBox(
                height: size.height / 2.2,
                child: GridView.builder(
                  itemCount: _selected.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => pickImage(index),
                    child: Container(
                      padding: const EdgeInsets.all(60),
                      decoration: BoxDecoration(
                        border: Border.all(color: green, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        image: (_selected[index] != null)
                            ? DecorationImage(
                                image: NetworkImage(_selected[index]!),
                                fit: BoxFit.cover)
                            : null,
                      ),
                      child: (_selected[index] != null)
                          ? null
                          : Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 6, bottom: 6),
                                  child: Image.asset(
                                    "assets/pictures/image.png",
                                    color: grey,
                                  ),
                                ),
                                const CircleAvatar(
                                  backgroundColor: green,
                                  radius: 12,
                                  child: Icon(Icons.add, color: white),
                                )
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // My vitals
              h2("My vitals", grey, 18),
              const SizedBox(height: 10),
              SizedBox(
                height: 65.0 * variable.length,
                child: ListView.builder(
                  itemCount: variable.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              select = index;
                              // switch (select) {
                              //   case 0:
                              //     UrlLauncher(
                              //         "https://hingeapp.zendesk.com/hc/en-us");
                              //     break;
                              //   // case 2:
                              //   //   Navigator.pushNamed(context, 'profile');
                              //   //   break;
                              //   case 2:
                              //     FirebaseAuth.instance.signOut();
                              //     Navigator.pushNamedAndRemoveUntil(
                              //         context, 'onboarding', (route) => false);
                              //     break;
                              // }
                            });
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                variable[index],
                                style: GoogleFonts.quicksand(
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                value[index],
                                style: GoogleFonts.quicksand(
                                    color: grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: grey),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Pet vitals
              h2("Pet vitals", grey, 18),
              const SizedBox(height: 10),
              SizedBox(
                height: 65.0 * petVariable.length,
                child: ListView.builder(
                  itemCount: petVariable.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              select = index;
                              // switch (select) {
                              //   case 0:
                              //     UrlLauncher(
                              //         "https://hingeapp.zendesk.com/hc/en-us");
                              //     break;
                              //   // case 2:
                              //   //   Navigator.pushNamed(context, 'profile');
                              //   //   break;
                              //   case 2:
                              //     FirebaseAuth.instance.signOut();
                              //     Navigator.pushNamedAndRemoveUntil(
                              //         context, 'onboarding', (route) => false);
                              //     break;
                              // }
                            });
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                petVariable[index],
                                style: GoogleFonts.quicksand(
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                petValue[index],
                                style: GoogleFonts.quicksand(
                                    color: grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: grey),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
