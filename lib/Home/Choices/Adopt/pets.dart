import 'package:flutter/material.dart';

import '../../../main_component.dart';
import '../../home_component.dart';

class Pets extends StatelessWidget {
  const Pets({super.key});

  button(Color backgroundColor, Widget child) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: white,
        iconColor: white,
        fixedSize: const Size.fromHeight(60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        surfaceTintColor: black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: white),
        ),
        actions: [
          IconButton(
            color: white,
            onPressed: () {},
            icon: const Icon(Icons.bookmark_border, color: white),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset('assets/pictures/german.png'),
            ),
          ),
          Expanded(
            child: Container(
              width: size.width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: background,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading("German Shepherd", black, 24),
                      h2("1.2 Km Away", grey, 16),
                      const SizedBox(height: 20),
                      heading("About", black, 18),
                      const SizedBox(height: 10),
                      h2(
                          "The German Shepherd, also known in Britain as an Alsatian, "
                          "is a German breed of working dog of medium to large size. The breed was developed"
                          " by Max von Stephanitz using various traditional German herding dogs from 1899. "
                          "It was originally bred as a herding dog, for herding sheep",
                          grey,
                          14),
                    ],
                  ),
                  Row(
                    children: [
                      button(black, const Icon(Icons.message)),
                      const SizedBox(width: 20),
                      Expanded(
                        child: button(green, h2("Adopt me", white, 16)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
