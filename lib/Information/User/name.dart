import 'package:flutter/material.dart';

import '../user_component.dart';

class Name extends StatefulWidget {
  const Name({super.key});

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  late TextEditingController firstName;
  late TextEditingController lastName;
  bool length = false;

  @override
  void initState() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
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
                  heading("What's your name?"),
                  const SizedBox(height: 40),

                  // FIRST NAME
                  CTextField(
                    controller: firstName,
                    hintText: "First Name",
                    onChanged: (value) {
                      setState(() {
                        length = value.isNotEmpty;
                      });
                    },
                    autofocus: true,
                  ),
                  const SizedBox(height: 40),

                  // LAST NAME
                  CTextField(
                    controller: lastName,
                    hintText: "Last Name",
                  ),
                ],
              ),

              // NAVIGATION BUTTON
              Container(
                alignment: Alignment.centerRight,
                child: authElevatedButton(
                  context,
                  length
                      ? () {
                          create(firstName.text, lastName.text);
                          Navigator.pushNamedAndRemoveUntil(context, 'dob', (route) => false);
                        }
                      : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
