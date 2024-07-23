import 'package:flutter/material.dart';

import 'package:breedit/Home/home_component.dart';
import 'package:breedit/main_component.dart';

class Prompts extends StatelessWidget {
  Prompts({super.key});

  final List<String> prompts = [
    "He go crazy for",
    "She go crazy for",
    "Unusual skills",
    "I recently discovered that",
    "Typical Sunday",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context, ""),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: const Text("Prompts"),
      ),
      body: ListView.builder(
        itemCount: prompts.length,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, index) => MaterialButton(
          onPressed: () => Navigator.pop(context, prompts[index]),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: heading(prompts[index], black, 14),
              ),
              Divider(
                color: black.withOpacity(0.3),
              )
            ],
          ),
        ),
      ),
    );
  }
}
