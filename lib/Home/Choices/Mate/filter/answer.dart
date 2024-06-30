import 'package:breedit/Home/home_component.dart';
import 'package:breedit/main_component.dart';
import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  const Answer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        surfaceTintColor: black,
        // leading: IconButton(onPressed: () => Navigator.pop, icon: Icon(Icons)),
        title: heading("Write answer", white, 20),
      ),
    );
  }
}
