import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/main_component.dart';
import 'home_component.dart';

class HomeInfo extends StatefulWidget {
  const HomeInfo({super.key});

  @override
  State<HomeInfo> createState() => _HomeInfoState();
}

class _HomeInfoState extends State<HomeInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: size.height / 1.65,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: heading(
                            "All done! Let's see who catches your eye."),
                      ),
                      Image.asset("assets/pictures/home.jpg"),
                    ],
                  ),
                  ElevatedButton(
                    // onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    //     context, 'home', (route) => false),
                    onPressed: () => Navigator.pushNamed(context, 'home'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: green,
                        shadowColor: Colors.transparent,
                        minimumSize: const Size.fromHeight(60),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10)))),
                    child: Text(
                      "Let's begin",
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold, color: white),
                    ),
                  )
                ],
              ),
            ),
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
      ),
    );
  }
}
