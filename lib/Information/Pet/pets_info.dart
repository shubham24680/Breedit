import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/main_component.dart';
import '/Information/user_component.dart';

class PetsInfo extends StatefulWidget {
  const PetsInfo({super.key});

  @override
  State<PetsInfo> createState() => _PetsInfoState();
}

class _PetsInfoState extends State<PetsInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: size.height / 1.65,
              decoration: BoxDecoration(
                  color: brown, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/pictures/cute_dog.jpg"),
                  heading("Do you have a pet?"),
                  const SizedBox(height: 5),
                  Text(
                    "You control how it appears and can update it at any time. While our process isn't prefect, we're always improving.",
                    style: GoogleFonts.quicksand(
                        color: black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  authElevatedButton(
                      context, () => Navigator.pushNamed(context, 'petName')),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Skip",
              style: GoogleFonts.quicksand(
                  color: black, fontWeight: FontWeight.w900, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
