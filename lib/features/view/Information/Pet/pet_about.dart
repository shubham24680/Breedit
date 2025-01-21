import 'package:breedit/core/util/app_colors.dart';
import 'package:breedit/features/view/Information/user_component.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PetAbout extends StatefulWidget {
  const PetAbout({super.key});

  @override
  State<PetAbout> createState() => _PetAboutState();
}

class _PetAboutState extends State<PetAbout> {
  late TextEditingController petAbout;

  @override
  void initState() {
    petAbout = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    petAbout.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          padding:
              const EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 80),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // IMAGE
                    image("assets/icons/lover.png"),
                    const SizedBox(height: 20),

                    // HEADING
                    heading("Tell us more about your pet."),
                    const SizedBox(height: 40),

                    // FIRST NAME
                    TextFormField(
                      controller: petAbout,
                      autofocus: true,
                      cursorColor: black,
                      maxLines: 10,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText:
                            "You can write about habits, likes, dislikes etc. about your pet.",
                        hintStyle: GoogleFonts.nunito(
                          color: grey,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),

                // NAVIGATION BUTTON
                Container(
                  alignment: Alignment.centerRight,
                  child: authElevatedButton(
                    context,
                    () {
                      if (petAbout.text.isNotEmpty) {
                        // petUpdate('about', petAbout.text);
                      }
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'homeInfo', (route) => false);
                    },
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
