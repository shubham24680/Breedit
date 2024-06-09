import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../main_component.dart';
import '../user_component.dart';
// import '../permissions.dart';

class PetProfilePhoto extends StatefulWidget {
  const PetProfilePhoto({super.key});

  @override
  State<PetProfilePhoto> createState() => _PetProfilePhotoState();
}

class _PetProfilePhotoState extends State<PetProfilePhoto> {
  final List<File?> _selected = List<File?>.generate(4, (index) => null);
  bool _uploading = false;
  final bool _uploaded = false;

  // Future pickImage(int index) async {
  //   try {
  //     if (await checkPermission()) {
  //       final image =
  //           await ImagePicker().pickImage(source: ImageSource.gallery);
  //       if (image == null) return;

  //       final imagePath = File(image.path);
  //       setState(() {
  //         _selected[index] = imagePath;
  //         _uploaded = true;
  //       });
  //     }
  //   } on PlatformException catch (e) {
  //     print("Error: $e");
  //   }
  // }

  Future<void> _uploadImages() async {
    try {
      setState(() {
        _uploading = true;
      });

      List<String> url = [];
      for (var image in _selected) {
        if (image != null) {
          String imageName = DateTime.now().millisecondsSinceEpoch.toString();
          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child('image/$imageName.jpg');
          firebase_storage.UploadTask uploadTask = ref.putFile(image);
          firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
          String dowloadUrl = await taskSnapshot.ref.getDownloadURL();
          url.add(dowloadUrl);
        }
      }
      // petUpdate('images', url);

      Timer(const Duration(seconds: 10), () {
        // setState(() {
          url.clear();
          _uploading = false;
        // });
        print("Successful");
      });
    } catch (e) {
      print('Error uploading images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        // await requestPermission();
        // if (!(await checkPermission())) {
        //   showDialog(
        //     barrierColor: Colors.black54,
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         backgroundColor: Colors.white,
        //         surfaceTintColor: Colors.transparent,
        //         title: heading("Enable Storage Services"),
        //         contentPadding: EdgeInsets.zero,
        //         content: Wrap(
        //           children: [
        //             Image.asset('assets/pictures/storage.jpg'),
        //             ElevatedButton(
        //               onPressed: () => requestPermission(context),
        //               style: ElevatedButton.styleFrom(
        //                 backgroundColor: green,
        //                 shadowColor: Colors.transparent,
        //                 minimumSize: const Size.fromHeight(60),
        //                 shape: const RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.vertical(
        //                       bottom: Radius.circular(20)),
        //                 ),
        //               ),
        //               child: Text(
        //                 "Enable",
        //                 style: GoogleFonts.quicksand(
        //                     fontWeight: FontWeight.bold, color: white),
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //   );
        // }
      },
    );

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
                  SizedBox(
                    height: size.height / 2,
                    child: GridView.builder(
                      itemCount: _selected.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        // onTap: () => pickImage(index),
                        child: Container(
                          padding: const EdgeInsets.all(60),
                          decoration: BoxDecoration(
                            border: Border.all(color: green, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            image: (_selected[index] != null)
                                ? DecorationImage(
                                    image: FileImage(_selected[index]!),
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
                ],
              ),

              // NAVIGATION BUTTON
              Container(
                alignment: Alignment.centerRight,
                child: _uploading
                    ? const CircularProgressIndicator(
                        color: green,
                      )
                    : authElevatedButton(
                        context,
                        (_uploaded)
                            ? () {
                                _uploadImages();
                                Navigator.pushNamedAndRemoveUntil(
                                    context, 'petAbout', (route) => false);
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
