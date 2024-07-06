import 'package:breedit/Home/home_component.dart';
import 'package:breedit/main_component.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Answer extends StatelessWidget {
  const Answer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        surfaceTintColor: black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: white),
        ),
        title: heading("Write answer", white, 20),
        actions: [
          IconButton(
            color: white,
            onPressed: () {},
            icon: const Icon(Icons.check_circle, color: white),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Container(
              height: 70,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: black.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(child: heading("I go crazy for", black, 16)),
                  VerticalDivider(color: black.withOpacity(0.3)),
                  const SizedBox(width: 10),
                  Icon(Icons.edit, color: black, size: 30),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Write answer",
                hintStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, color: grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
