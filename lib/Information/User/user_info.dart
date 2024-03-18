import 'package:flutter/material.dart';

import '../../main_component.dart';
import '../user_component.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
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
                          "You're one of a kind. Your profile should be, too."),
                    ),
                    Image.asset("assets/pictures/pets.jpg"),
                  ],
                ),
                longButton(context, 'name', "Enter basic info"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
