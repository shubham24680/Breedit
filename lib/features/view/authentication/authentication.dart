import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:breedit/features/view/Information/information.dart';
import 'package:breedit/features/view/onboarding/onboarding_screen.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Display a loading indicator when waiting for data.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const OnboardingScreen();
        } else {
          return const Information();
        }
        //   String uid = snapshot.data!.uid;
        //   final ref = FirebaseFirestore.instance.collection('users').doc(uid);
        //   return FutureBuilder(
        //     future: ref.get(),
        //     builder: (context, snapshot) {
        //       if (!snapshot.hasData || !snapshot.data!.exists) {
        //         // return const Information();
        //       }
        //       return const Home();
        //     },
        //   );
      },
    );
  }
}
