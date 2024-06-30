import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../../main_component.dart';

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

  // Future<void> _uploadImages() async {
  //   try {
  //     setState(() {
  //       _uploading = true;
  //     });

  //     List<String> url = [];
  //     for (var image in _selected) {
  //       if (image != null) {
  //         String imageName = DateTime.now().millisecondsSinceEpoch.toString();
  //         firebase_storage.Reference ref = firebase_storage
  //             .FirebaseStorage.instance
  //             .ref()
  //             .child('image/$imageName.jpg');
  //         firebase_storage.UploadTask uploadTask = ref.putFile(image);
  //         firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
  //         String dowloadUrl = await taskSnapshot.ref.getDownloadURL();
  //         url.add(dowloadUrl);
  //       }
  //     }
  // petUpdate('images', url);

  //     Timer(const Duration(seconds: 10), () {
  //       // setState(() {
  //         url.clear();
  //         _uploading = false;
  //       // });
  //       print("Successful");
  //     });
  //   } catch (e) {
  //     print('Error uploading images: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height / 2,
      child: GridView.builder(
        itemCount: _selected.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) => GestureDetector(
          // onTap: () => pickImage(),
          child: Container(
            decoration: BoxDecoration(
              color: background,
              border: Border.all(color: black),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: _selected[index] != null
                    ? FileImage(_selected[index]!) as ImageProvider
                    : const AssetImage('assets/pictures/add.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
