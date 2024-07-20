import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main_component.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "You're one of a kind. Your profile should be, too.",
                    style: GoogleFonts.manrope(
                        color: black,
                        fontSize: 28,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Image.asset("assets/pictures/pets.jpg"),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, 'userInformation', (route) => false),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: white,
                    backgroundColor: green,
                    shadowColor: Colors.transparent,
                    minimumSize: const Size.fromHeight(50),
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(25)),
                    ),
                  ),
                  child: Text(
                    "Enter basic info",
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold, color: white),
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
