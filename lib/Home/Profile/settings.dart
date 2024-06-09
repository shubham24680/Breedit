import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main_component.dart';
import '../home_component.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int select = 0;
  List<String> button = [
    "Settings",
    "Edit profile",
    "Feedback",
    "Help centre",
    "Sign out"
  ];
  List<String> icon = [
    "assets/icons/filter.svg",
    "assets/icons/edit_profile.svg",
    "assets/icons/feedback.svg",
    "assets/icons/help-centre.svg",
    "assets/icons/signout.svg"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73.0 * button.length,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: ListView.builder(
        itemCount: button.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              MaterialButton(
                onPressed: () {
                  setState(() {
                    select = index;
                    switch (select) {
                      case 3:
                        UrlLauncher("https://hingeapp.zendesk.com/hc/en-us");
                        break;
                      case 4:
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'onboarding', (route) => false);
                        break;
                    }
                  });
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      icon[index],
                      color: black,
                      height: 24,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      button[index],
                      style: GoogleFonts.quicksand(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              Divider(color: grey),
            ],
          );
        },
      ),
    );
  }
}
