import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_component.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/profile.svg", height: 100),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: (() {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'onboarding', (route) => false);
            }),
            child: Text(
              "Sign out",
              style: GoogleFonts.quicksand(
                  color: black, fontWeight: FontWeight.w900, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
