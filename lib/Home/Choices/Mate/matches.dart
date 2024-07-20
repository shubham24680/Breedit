import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main_component.dart';
import '../../home_component.dart';

class Matches extends StatefulWidget {
  const Matches({super.key});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  bool mateExists = false;
  String name = "";

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        name = userData['first name'] + " " + userData['last name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    noProfile() {
      return Column(
        children: [
          Image.asset('assets/pictures/cute_dog.png'),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, 'edit'),
            style: ElevatedButton.styleFrom(
              foregroundColor: white,
              backgroundColor: green,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: subheading("Edit pet profile", white, 16),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        surfaceTintColor: background,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined, color: black),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'edit'),
            icon: Icon(Icons.filter_list, color: black),
          ),
        ],
      ),
      body: mateExists
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Stories(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 100),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heading(name, Colors.grey.shade900, 32),
                                Text(
                                  "Active today",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: green),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_horiz),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        ImageCard(url: "assets/pictures/wallpaperflare.jpg"),
                        const SizedBox(height: 20),
                        const TextCard(top: "I go crazy for", bottom: "Meat"),
                        const SizedBox(height: 20),
                        ImageCard(url: "assets/pictures/1324832.png"),
                        const SizedBox(height: 20),
                        ImageCard(url: "assets/pictures/8733690.jpg"),
                        const SizedBox(height: 20),
                        const TextCard(
                            top: "Unusual skills", bottom: "Football"),
                        const SizedBox(height: 20),
                        ImageCard(url: "assets/pictures/20200304_020853.jpg"),
                        const SizedBox(height: 20),
                        const TextCard(
                            top: "My greatest strength", bottom: "Anime"),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : noProfile(),
      floatingActionButton: mateExists
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: green,
              child: const Icon(Icons.close, color: white),
            )
          : null,
    );
  }
}
