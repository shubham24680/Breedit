import 'package:breedit/core/widgets/text.dart';
import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Quicksand(text: "Information", size: 36),
      ),
    );
  }
}
