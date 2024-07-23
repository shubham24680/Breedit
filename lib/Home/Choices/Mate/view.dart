import 'package:flutter/material.dart';

import '../../home_component.dart';

class Views extends StatelessWidget {
  const Views({super.key, required this.item});

  final List<String?> item;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            item[0] != null ? image(size, item[0]!) : const SizedBox(),
            const SizedBox(height: 20),
            // card(size, "I go crazy for", "Meat"),
            // const SizedBox(height: 20),
            item[1] != null ? image(size, item[1]!) : const SizedBox(),
            const SizedBox(height: 20),
            item[2] != null ? image(size, item[2]!) : const SizedBox(),
            const SizedBox(height: 20),
            // image(size, "assets/pictures/8733690.jpg"),
            // const SizedBox(height: 20),
            // card(size, "Unusual skills", "Football"),
            // const SizedBox(height: 20),
            item[3] != null ? image(size, item[3]!) : const SizedBox(),
            const SizedBox(height: 20),
            // card(size, "My greatest strength", "Anime"),
          ],
        ),
      ),
    );
  }
}
