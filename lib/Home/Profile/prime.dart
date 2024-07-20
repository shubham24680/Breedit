import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main_component.dart';
import '../home_component.dart';

class Prime extends StatelessWidget {
  const Prime({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: green.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Image.asset(
                (index == 0)
                    ? "assets/icons/paper-plane.png"
                    : "assets/icons/rocket.png",
                color: green,
                height: 50),
            const SizedBox(height: 10),
            Text(
              (index == 0) ? "PRO" : "PRIME",
              style: GoogleFonts.merriweather(
                  fontSize: 26,
                  // fontWeight: FontWeight.bold,
                  color: green),
            ),
            // const SizedBox(height: 10),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                Text(
                  "₹ ",
                  style: GoogleFonts.quicksand(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  (index == 0) ? "299" : "3299",
                  style: GoogleFonts.quicksand(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  (index == 0) ? "for a month" : " for a year",
                  style: GoogleFonts.quicksand(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(color: green),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  offer("Personalised recommendations"),
                  offer("Ad free experience"),
                  offer("Stay on top of the news"),
                  offer("Topic of interest selected by you"),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  foregroundColor: white,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              child: Text(
                "Get Started",
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, color: white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
