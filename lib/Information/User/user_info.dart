import 'package:flutter/material.dart';

import '../user_component.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: customCard(
          context,
          "You're one of a kind. Your profile should be, too.",
          "assets/pictures/pets.jpg",
          'name',
          "Enter basic info",
        ),
      ),
    );
  }
}
