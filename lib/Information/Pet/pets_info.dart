// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '/main_component.dart';
// import '/Information/user_component.dart';

// class PetsInfo extends StatefulWidget {
//   const PetsInfo({super.key});

//   @override
//   State<PetsInfo> createState() => _PetsInfoState();
// }

// class _PetsInfoState extends State<PetsInfo> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               height: size.height / 1.5,
//               decoration: BoxDecoration(
//                   color: brown, borderRadius: BorderRadius.circular(10)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Image.asset("assets/pictures/cute_dog.jpg"),
//                         heading("Have you got any pets at home?"),
//                         const SizedBox(height: 5),
//                         Text(
//                           "You control how it appears and can update it at any time. While our process isn't prefect, we're always improving.",
//                           style: GoogleFonts.quicksand(
//                               color: black, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   longButton(context, 'petChoice', "Enter pets info"),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
