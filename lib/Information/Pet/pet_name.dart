import 'package:flutter/material.dart';

import '../user_component.dart';

class PetName extends StatefulWidget {
  const PetName({super.key});

  @override
  State<PetName> createState() => _PetNameState();
}

class _PetNameState extends State<PetName> {
  late TextEditingController petName;
  bool length = false;

  @override
  void initState() {
    petName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    petName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // IMAGE
                  image("assets/icons/id-card.png"),
                  const SizedBox(height: 20),

                  // HEADING
                  heading("What's your pet name?"),
                  const SizedBox(height: 40),

                  // FIRST NAME
                  CTextField(
                    controller: petName,
                    hintText: "Pet Name",
                    onChanged: (value) {
                      setState(() {
                        length = value.isNotEmpty;
                      });
                    },
                    autofocus: true,
                  ),
                ],
              ),

              // NAVIGATION BUTTON
              Container(
                alignment: Alignment.centerRight,
                child: authElevatedButton(
                  context,
                  length ? () {
                    // petUpdate('name', petName.text);
                    Navigator.pushNamedAndRemoveUntil(context, 'petBreed', (route) => false);
                  } : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
