import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../main_component.dart';
import '../../permissions.dart';
import '../user_component.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController dob;
  File? _selected;
  bool name = false;
  bool birth = false;
  int select = 0;

  List<String> gender = ["Male", "Female", "Non-binary"];

  @override
  void initState() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    dob = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    dob.dispose();
    super.dispose();
  }

  Future pickImage() async {
    try {
      if (await checkPermission()) {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;

        final imagePath = File(image.path);
        setState(() {
          _selected = imagePath;
        });
      }
    } on PlatformException catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _uploadImages() async {
    try {
      if (_selected != null) {
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('image/$imageName.jpg');
        firebase_storage.UploadTask uploadTask = ref.putFile(_selected!);
        firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
        String dowloadUrl = await taskSnapshot.ref.getDownloadURL();
        update('images', dowloadUrl);
        print("Successful");
      }
    } catch (e) {
      print('Error uploading images: $e');
    }
  }

  showDate() {
    showDatePicker(
            context: context,
            builder: (context, child) => Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                    primary: green,
                  )),
                  child: child!,
                ),
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((value) {
      dob.text = value != null
          ? "${value.day}-${value.month}-${value.year}"
          : dob.text;
      setState(() {
        birth = dob.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PROFILE PHOTO
                const SizedBox(height: 80),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () => pickImage(),
                    child: CircleAvatar(
                      radius: 92,
                      backgroundColor: black,
                      child: CircleAvatar(
                        backgroundColor: background,
                        radius: 90,
                        backgroundImage: _selected != null
                            ? FileImage(_selected!) as ImageProvider
                            : const AssetImage('assets/pictures/add.png'),
                      ),
                    ),
                  ),
                ),

                // NAME
                const SizedBox(height: 80),

                // IMAGE
                image("assets/icons/id-card.png"),
                const SizedBox(height: 20),

                // HEADING
                heading("What's your name?"),
                const SizedBox(height: 40),

                // FIRST NAME
                CTextField(
                  controller: firstName,
                  hintText: "First Name",
                  onChanged: (value) {
                    setState(() {
                      name = value.isNotEmpty;
                    });
                  },
                  autofocus: true,
                ),
                const SizedBox(height: 40),

                // LAST NAME
                CTextField(
                  controller: lastName,
                  hintText: "Last Name",
                ),

                // DOB
                const SizedBox(height: 80),
                // IMAGE
                image("assets/icons/birthday.png"),
                const SizedBox(height: 20),

                // HEADING
                heading("What's your date of birth?"),
                const SizedBox(height: 40),

                // DATE OF BIRTH
                CTextField(
                  controller: dob,
                  hintText: "Date of birth",
                  onTap: () => showDate(),
                  readOnly: true,
                ),

                // GENDER
                const SizedBox(height: 80),
                // IMAGE
                image("assets/icons/gender.png"),
                const SizedBox(height: 20),

                // HEADING
                heading("Which gender best describes you?"),
                const SizedBox(height: 40),

                // GENDER SELECTION
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: gender.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Column(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              select = index;
                            });
                          },
                          height: 50,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                gender[index],
                                style: GoogleFonts.quicksand(
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              CircleAvatar(
                                backgroundColor:
                                    (select == index) ? green : grey,
                                radius: 7,
                                child: CircleAvatar(
                                  backgroundColor:
                                      (select == index) ? white : grey,
                                  radius: 3,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(color: Colors.grey),
                      ],
                    ),
                  ),
                ),

                // NAVIGATION BUTTON
                const SizedBox(height: 80),
                Container(
                  alignment: Alignment.centerRight,
                  child: authElevatedButton(
                    context,
                    name && birth && _selected != null
                        ? () {
                            create(firstName.text, lastName.text, dob.text,
                                gender[select]);
                            _uploadImages();
                            Timer(const Duration(seconds: 10), () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'home', (route) => false);
                            });
                          }
                        : null,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
