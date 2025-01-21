import 'package:breedit/core/util/app_colors.dart';
import 'package:breedit/features/view/Information/user_component.dart';
import 'package:flutter/material.dart';

class PetChoice extends StatefulWidget {
  const PetChoice({super.key});

  @override
  State<PetChoice> createState() => _PetChoiceState();
}

class _PetChoiceState extends State<PetChoice> {
  int select = 0;
  final List<String> pets = [
    'assets/pictures/dogie.jpg',
    'assets/pictures/cat.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // IMAGE
                  image("assets/icons/pet.png"),
                  const SizedBox(height: 20),

                  // HEADING
                  heading("What's your choice?"),
                  const SizedBox(height: 40),

                  // PET SELECTION
                  SizedBox(
                    height: size.height / 2,
                    child: GridView.builder(
                      itemCount: pets.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            select = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: (select == index)
                                ? Border.all(width: 3, color: black)
                                : null,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(pets[index], fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              // NAVIGATION BUTTON
              Container(
                alignment: Alignment.centerRight,
                child: authElevatedButton(
                  context,
                  () {
                    // petCreate((select == 0) ? "Dog" : "Cat");
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'petName', (route) => false);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
