import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/main_component.dart';

class Choice extends StatefulWidget {
  const Choice({super.key});

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  final List<List<String>> item = [
    ["assets/pictures/krista.jpg", "assets/icons/pawprint.png", "MATE", 'mate'],
    ["assets/pictures/eric.jpg", "assets/icons/adoption.png", "ADOPT", 'adopt'],
    ["assets/pictures/jamie.jpg", "assets/icons/animal.png", "DONATE", 'donate']
  ];

  Widget options(int index) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, item[index][3]),
      child: Card(
        color: black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.asset(
                item[index][0],
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(
                    item[index][1],
                    color: white,
                    height: 40,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    item[index][2],
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      color: white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: item.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: options(index),
          );
        },
      ),
    );
  }
}
