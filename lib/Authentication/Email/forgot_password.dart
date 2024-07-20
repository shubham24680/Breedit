// import 'package:breedit/Authentication/auth_component.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '/main_component.dart';

// class ForgotPassword extends StatefulWidget {
//   const ForgotPassword({super.key});

//   @override
//   State<ForgotPassword> createState() => _ForgotPasswordState();
// }

// class _ForgotPasswordState extends State<ForgotPassword> {
//   final _emailController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     super.dispose();
//   }

//   Future forgotPassword(context) async {
//     try {
//       await FirebaseAuth.instance
//           .sendPasswordResetEmail(email: _emailController.text);
//       showDialog(
//           context: context,
//           builder: (context) {
//             return const AlertDialog(
//               content: Text(
//                   "A reset link has been sent to your registered email. Please use it to reset your password."),
//             );
//           });
//     } on FirebaseAuthException catch (e) {
//       Navigator.pop(context);
//       showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               content: Text(e.code),
//             );
//           });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: black,
//           surfaceTintColor: black,
//           leading: IconButton(
//             onPressed: () => Navigator.pop(context),
//             icon: const Icon(Icons.arrow_back, color: white),
//           ),
//           title: Text(
//             "Password reset",
//             style: GoogleFonts.manrope(
//                 fontSize: 20, fontWeight: FontWeight.bold, color: white),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 30),
//                 Text(
//                   "Please enter your email address.",
//                   style: GoogleFonts.quicksand(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 20),
//                 CTextField(controller: _emailController, hintText: "Email"),
//                 const SizedBox(height: 20),
//                 const CElevatedButton(
//                     text: "Send Link", backgroundColor: green, route: 'login'),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
