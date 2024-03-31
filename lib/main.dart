import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:breedit/firebase_options.dart';

import 'theme.dart';
import 'route.dart';
import 'OnboardingScreen/onboarding_screen.dart';
import 'Home/home_info.dart';
import 'Information/User/user_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      routes: routes,
      home: const Security(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  late Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String uid = snapshot.data!.uid;
          final ref = FirebaseFirestore.instance.collection('users').doc(uid).collection('pet').doc(uid);
          return FutureBuilder(
            future: ref.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.exists) {
                data = snapshot.data!.data();
                if (data!.containsKey('images')) {
                  return const HomeInfo();
                }
              }
              return const UserInformation();
            },
          );
        }
        return const OnboardingScreen();
      },
    );
  }
}
