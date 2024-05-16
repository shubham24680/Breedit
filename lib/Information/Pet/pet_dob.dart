import 'package:flutter/material.dart';

import '../../main_component.dart';
import '../user_component.dart';

class PetDOB extends StatefulWidget {
  const PetDOB({super.key});

  @override
  State<PetDOB> createState() => _PetDOBState();
}

class _PetDOBState extends State<PetDOB> {
  late TextEditingController dob;
  bool length = false;

  @override
  void initState() {
    dob = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    dob.dispose();
    super.dispose();
  }

  showDate() {
    showDatePicker(
            context: context,
            builder: (context, child) => Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                    primary: green,
                  )),
                  child: child!,
                ),
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((value) {
      dob.text =
          value != null ? "${value.day}-${value.month}-${value.year}" : dob.text;
          setState(() {
            length = dob.text.isNotEmpty;
          });
    });
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
                  image("assets/icons/birthday.png"),
                  const SizedBox(height: 20),

                  // HEADING
                  heading("What's your pet date of birth?"),
                  const SizedBox(height: 40),

                  // DATE OF BIRTH
                  CTextField(
                    controller: dob,
                    hintText: "Date of birth",
                    onTap: () => showDate(),
                    readOnly: true,
                  ),
                ],
              ),

              // NAVIGATION BUTTON
              Container(
                alignment: Alignment.centerRight,
                child: authElevatedButton(
                  context,
                  length ? () {
                    // petUpdate('dob', dob.text);
                    Navigator.pushNamedAndRemoveUntil(context, 'petGender', (route) => false);
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
