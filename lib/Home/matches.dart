import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_component.dart';
import 'home_component.dart';

class Matches extends StatefulWidget {
  const Matches({super.key});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  int selectIndex = 0;
  String name = "";
  List<String> url = [];

    @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        name = data['first name'] + " " + data['last name'];
        // url = List.from(petData['images']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heading(name),
                    Text("Active today",
                        style: GoogleFonts.quicksand(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: green)),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                )
              ],
            ),
            SizedBox(
              height: (size.width + 20) * (url.length),
              child: ListView.builder(
                itemCount: url.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      ImageCard(url: url, index: index),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//                 child: Column(
//               children: [
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Shubham Patel",
//                                   style: GoogleFonts.manrope(
//                                       fontSize: 30,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.grey.shade900)),
//                               Text("Active today",
//                                   style: GoogleFonts.quicksand(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                       color: green)),
//                             ],
//                           ),
//                           IconButton(
//                             onPressed: () {},
//                             icon: const Icon(Icons.more_horiz),
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.asset("assets/pictures/storage.jpg",
//                             fit: BoxFit.contain),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             )),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            //   child: Container(
            //     padding:
            //         const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
            //     width: MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "I go crazy for",
            //           style: GoogleFonts.quicksand(
            //               fontWeight: FontWeight.bold,
            //               color: Colors.grey.shade900),
            //         ),
            //         Text(
            //           "Meat",
            //           style: GoogleFonts.ptSerif(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 40,
            //               color: Colors.grey.shade900),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     // child: Image.asset("assets/pictures/gear4.jpg",
            //     //     fit: BoxFit.contain),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     // child: Image.asset("assets/pictures/gear5.png",
            //     //     fit: BoxFit.contain),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: Container(
            //     padding:
            //         const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
            //     width: MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "Don't hate me if I",
            //           style: GoogleFonts.quicksand(
            //               fontWeight: FontWeight.bold,
            //               color: Colors.grey.shade900),
            //         ),
            //         Text(
            //           "Roast you",
            //           style: GoogleFonts.ptSerif(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 40,
            //               color: Colors.grey.shade900),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     // child: Image.asset("assets/pictures/crew.jpg",
            //     //     fit: BoxFit.contain),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: Container(
            //     padding:
            //         const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
            //     width: MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "We'll get along if",
            //           style: GoogleFonts.quicksand(
            //               fontWeight: FontWeight.bold,
            //               color: Colors.grey.shade900),
            //         ),
            //         Text(
            //           "You're good with comebacks",
            //           style: GoogleFonts.ptSerif(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 40,
            //               color: Colors.grey.shade900),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 100),
    //       ],
    //     ),
    //   ),
    // );