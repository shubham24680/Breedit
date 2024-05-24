import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/main_component.dart';
// import '../home_component.dart';

class Choice extends StatefulWidget {
  const Choice({super.key});

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  // int selectIndex = 0;
  // String name = "";

  // @override
  // void initState() {
  //   super.initState();
  //   if (mounted) {
  //     setState(() {
  //       name = data['first name'] + " " + data['last name'];
  //     });
  //   }
  // }

  final List<List<String>> item = [
    ["assets/pictures/krista.jpg", "assets/icons/pawprint.png", "MATE"],
    ["assets/pictures/eric.jpg", "assets/icons/adoption.png", "ADOPT"],
    ["assets/pictures/jamie.jpg", "assets/icons/animal.png", "DONATE"]
  ];

  options(index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 200,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // border: Border.all(color: white, width: 5),
          image: DecorationImage(
            image: AssetImage(item[index][0]),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(4, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              item[index][1],
              color: white,
              height: 50,
            ),
            const SizedBox(height: 10),
            Text(
              item[index][2],
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                fontSize: 30,
                color: white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < item.length; i++) options(i),
        ],
      ),
    );
  }
}
