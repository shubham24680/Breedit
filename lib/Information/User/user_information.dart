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
  bool isDone = true;
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
        update({'images': dowloadUrl});
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
                      colorScheme: const ColorScheme.light(primary: green)),
                  child: child!,
                ),
            initialDate: DateTime.now(),
            firstDate: DateTime(1970),
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
        appBar: AppBar(
          title: const Text("User Profile"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // PROFILE PHOTO
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
                const SizedBox(height: 40),

                // NAME
                image("assets/icons/id-card.png"),
                const SizedBox(height: 10),
                heading("What's your name?"),
                const SizedBox(height: 20),
                // FIRST NAME
                CTextField(
                  controller: firstName,
                  hintText: "First Name",
                  onChanged: (value) {
                    setState(() {
                      name = value.isNotEmpty;
                    });
                  },
                ),
                const SizedBox(height: 10),
                // LAST NAME
                CTextField(
                  controller: lastName,
                  hintText: "Last Name",
                ),
                const SizedBox(height: 40),

                // DOB
                image("assets/icons/birthday.png"),
                const SizedBox(height: 10),
                heading("What's your date of birth?"),
                const SizedBox(height: 20),
                CTextField(
                  controller: dob,
                  hintText: "Date of birth",
                  onTap: () => showDate(),
                  readOnly: true,
                ),
                const SizedBox(height: 40),

                // GENDER
                image("assets/icons/gender.png"),
                const SizedBox(height: 10),
                heading("Which gender best describes you?"),
                const SizedBox(height: 20),
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
                        Divider(color: grey),
                      ],
                    ),
                  ),
                ),

                // NAVIGATION BUTTON
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerRight,
                  child: isDone
                      ? authElevatedButton(
                          context,
                          name && birth && _selected != null
                              ? () {
                                  setState(() {
                                    isDone = false;
                                  });
                                  create({
                                    'first name': firstName.text,
                                    'last name': lastName.text,
                                    'date of birth': dob.text,
                                    'gender': gender[select],
                                  });
                                  _uploadImages();
                                  Timer(const Duration(seconds: 5), () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, 'home', (route) => false);
                                  });
                                }
                              : null,
                        )
                      : const CircularProgressIndicator(color: green),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
