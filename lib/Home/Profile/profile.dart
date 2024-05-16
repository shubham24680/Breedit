import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../main_component.dart';
import '../../permissions.dart';
import '../home_component.dart';
import 'prime.dart';
import 'settings.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String image = "";

  Future pickImage() async {
    try {
      if (await checkPermission()) {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;

        final imagePath = File(image.path);
        _uploadImages(imagePath);
      }
    } on PlatformException catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _uploadImages(imagePath) async {
    try {
      if (imagePath != null) {
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.refFromURL(image);
        firebase_storage.UploadTask uploadTask = ref.putFile(imagePath!);
        firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
        String dowloadUrl = await taskSnapshot.ref.getDownloadURL();
        update('images', dowloadUrl);
        getData();
        print("Successful");
      }
    } catch (e) {
      print('Error uploading images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getData();
      if (mounted) {
        setState(() {
          name = data['first name'] + " " + data['last name'];
          image = data['images'];
        });
      }
    });

    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // PROFILE PICTURE
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 72),
                height: MediaQuery.of(context).size.height / 8,
                color: black,
              ),
              GestureDetector(
                onTap: () => pickImage(),
                child: CircleAvatar(
                  radius: 72,
                  backgroundColor: black,
                  child: CircleAvatar(
                    backgroundColor: background,
                    radius: 70,
                    backgroundImage: image != ""
                        ? NetworkImage(image) as ImageProvider
                        : const AssetImage('assets/pictures/add.png'),
                  ),
                ),
              ),
            ],
          ),

          // NAME
          const SizedBox(height: 10),
          heading(name),

          // PHONE NUMBER
          // const SizedBox(height: 5),
          // subheading(user!.phoneNumber ?? ""),

          // OPTIONS
          const SizedBox(height: 20),
          TabBar(
            indicatorColor: black,
            dividerColor: background,
            labelColor: Colors.grey.shade900,
            unselectedLabelColor: Colors.grey,
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return green; //<-- SEE HERE
                }
                return null;
              },
            ),
            tabs: [
              // PRIME
              Tab(
                child: Text(
                  "PRIME",
                  style: GoogleFonts.manrope(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // EDIT
              Tab(
                child: Text(
                  "EDIT",
                  style: GoogleFonts.manrope(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                Prime(),
                Settings(),
              ],
            ),
          )
        ],
      ),
    );
  }
}



// return Padding(
//       padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 80),
//       child: Center(
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset("assets/icons/profile.svg", height: 100),
//             const SizedBox(height: 20),
//             const Text("Shubham Patel"),
//             SizedBox(
//               height: 200,
//               child: ListView.builder(
//                 itemCount: 3,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) => Column(
//                   children: [
//                     MaterialButton(
//                       // onPressed: () {
//                       //   setState(() {
//                       //     select = index;
//                       //   });
//                       // },
//                       onPressed: () {},
//                       height: 50,
//                       highlightColor: Colors.transparent,
//                       splashColor: Colors.transparent,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "gender[index]",
//                             style: GoogleFonts.quicksand(
//                                 color: black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16),
//                           ),
//                           // CircleAvatar(
//                           //   backgroundColor: (select == index) ? green : grey,
//                           //   radius: 7,
//                           //   child: CircleAvatar(
//                           //     backgroundColor: (select == index) ? white : grey,
//                           //     radius: 3,
//                           //   ),
//                           // )
//                         ],
//                       ),
//                     ),
//                     const Divider(color: Colors.grey),
//                   ],
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: (() {
//                 FirebaseAuth.instance.signOut();
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, 'onboarding', (route) => false);
//               }),
//               child: Text(
//                 "Sign out",
//                 style: GoogleFonts.quicksand(
//                     color: black, fontWeight: FontWeight.w900, fontSize: 16),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
