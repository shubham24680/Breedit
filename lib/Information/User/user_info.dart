import 'package:breedit/Authentication/auth_component.dart';
import 'package:breedit/OnboardingScreen/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../main_component.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/pictures/soon.png"),
          authElevatedButton(context, () => Navigator.pushNamed(context, 'name')),
          MaterialButton(
            onPressed: (() {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return const OnboardingScreen();
              }), (route) => false);
            }),
            color: green,
            child: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
