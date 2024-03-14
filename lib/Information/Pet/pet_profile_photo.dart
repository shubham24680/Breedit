import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../main_component.dart';
import '../user_component.dart';

class PetProfilePhoto extends StatefulWidget {
  const PetProfilePhoto({super.key});

  @override
  State<PetProfilePhoto> createState() => _PetProfilePhotoState();
}

class _PetProfilePhotoState extends State<PetProfilePhoto> {
  File? selected;
  File? selected2;

  Future pickImage(int id) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imagePath = File(image.path);
      setState(() {
        if (id == 1) {
          selected = imagePath;
        } else {
          selected2 = imagePath;
        }
      });
    } on PlatformException catch (e) {
      print("Error: $e");
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
                  image("assets/icons/profile.png"),
                  const SizedBox(height: 20),

                  // HEADING
                  heading("Pick your profile photo"),
                  const SizedBox(height: 40),

                  // PHOTO SELECTION
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => pickImage(1),
                        child: Container(
                          height: 150,
                          width: 150,
                          padding: const EdgeInsets.all(50),
                          decoration: BoxDecoration(
                            border: Border.all(color: green, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            image: (selected != null)
                                ? DecorationImage(
                                    image: FileImage(selected!),
                                    fit: BoxFit.cover)
                                : null,
                          ),
                          child: (selected != null)
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
                      GestureDetector(
                        onTap: () => pickImage(2),
                        child: Container(
                          height: 150,
                          width: 150,
                          padding: const EdgeInsets.all(50),
                          decoration: BoxDecoration(
                            border: Border.all(color: green, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            image: (selected2 != null)
                                ? DecorationImage(
                                    image: FileImage(selected2!),
                                    fit: BoxFit.cover)
                                : null,
                          ),
                          child: (selected2 != null)
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
                    ],
                  )
                ],
              ),

              // NAVIGATION BUTTON
              Container(
                alignment: Alignment.centerRight,
                child: authElevatedButton(
                  context,
                  (selected != null)
                      ? () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'home', (route) => false);
                        }
                      : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
