import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main_component.dart';
import '../user_component.dart';

class PetGender extends StatefulWidget {
  const PetGender({super.key});

  @override
  State<PetGender> createState() => _PetGenderState();
}

class _PetGenderState extends State<PetGender> {
  int select = 0;

  List<String> gender = ["Male", "Female"];

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
                  image("assets/icons/gender.png"),
                  const SizedBox(height: 20),

                  // HEADING
                  heading("Which gender best describes for your pet?"),
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
                  )
                ],
              ),

              // NAVIGATION BUTTON
              Container(
                alignment: Alignment.centerRight,
                child: authElevatedButton(
                  context,
                  () {
                    petUpdate('gender', gender[select]);
                    Navigator.pushNamedAndRemoveUntil(context, 'petProfilePhoto', (route) => false);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
