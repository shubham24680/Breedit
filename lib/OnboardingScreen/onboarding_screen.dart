import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_component.dart';
import 'onboard_component.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/pictures/dog.jpg"),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      const TextSpan(
                          text:
                              "By tapping Sign in or Create account, you agree to our "),
                      textButton("Terms of Service.", "https://hinge.co/terms"),
                      const TextSpan(
                          text: " Learn how we process your data in our "),
                      textButton("Privacy Policy", "https://hinge.co/privacy"),
                      const TextSpan(text: " and "),
                      textButton(
                          "Cookies Policy.", "https://hinge.co/cookie-policy"),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const CElevatedButton(
                  text: "Create account",
                  backgroundColor: green,
                  route: 'createAccount',
                ),
                const SizedBox(height: 20),
                const CElevatedButton(
                  text: "Sign in",
                  backgroundColor: Colors.transparent,
                  route: 'createAccount',
                ),
              ],
            ),
          ),
        ),
    );
  }
}
