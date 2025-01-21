import 'package:breedit/features/view/Information/user_component.dart';
import 'package:flutter/material.dart';

class PetBreed extends StatefulWidget {
  const PetBreed({super.key});

  @override
  State<PetBreed> createState() => _PetBreedState();
}

class _PetBreedState extends State<PetBreed> {
  late TextEditingController petBreed;
  bool length = false;

  @override
  void initState() {
    petBreed = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    petBreed.dispose();
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
                  image("assets/icons/breed.png"),
                  const SizedBox(height: 20),

                  // HEADING
                  heading("What's your pet breed?"),
                  const SizedBox(height: 40),

                  // FIRST NAME
                  CTextField(
                    controller: petBreed,
                    hintText: "Pet Breed",
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
                  length
                      ? () {
                          // petUpdate('breed', petBreed.text);
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'petDob', (route) => false);
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
