import 'package:flutter/material.dart';

import '../../../home_component.dart';

class Views extends StatelessWidget {
  const Views({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            image(size, "assets/pictures/wallpaperflare.jpg"),
            const SizedBox(height: 20),
            const TextCard(top: "I go crazy for", bottom: "Meat"),
            const SizedBox(height: 20),
            image(size, "assets/pictures/1324832.png"),
            const SizedBox(height: 20),
            image(size, "assets/pictures/8733690.jpg"),
            const SizedBox(height: 20),
            const TextCard(top: "Unusual skills", bottom: "Football"),
            const SizedBox(height: 20),
            image(size, "assets/pictures/20200304_020853.jpg"),
            const SizedBox(height: 20),
            const TextCard(top: "My greatest strength", bottom: "Anime"),
          ],
        ),
      ),
    );
  }
}
