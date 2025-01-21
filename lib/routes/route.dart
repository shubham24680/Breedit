import 'package:flutter/material.dart';

import 'package:breedit/features/view/onboarding/onboarding_screen.dart';
import 'package:breedit/features/view/authentication/phone/phone_number.dart';
import 'package:breedit/features/view/authentication/phone/otp_screen.dart';
import 'package:breedit/features/view/Information/information.dart';
// import '../features/view/Home/home.dart';
// import '../features/view/Home/Choices/Mate/matches.dart';
// import '../features/view/Home/Choices/Mate/edit.dart';
// import '../features/view/Home/Choices/Mate/Edit/prompt.dart';
// import '../features/view/Home/Choices/Adopt/adopt.dart';
// import '../features/view/Home/Choices/Adopt/pets.dart';
// import '../features/view/Home/Choices/donate.dart';

Map<String, WidgetBuilder> routes = {
  '/onboarding': (context) => const OnboardingScreen(),
  '/phoneNumber': (context) => const PhoneNumber(),
  '/otp': (context) => const OTPScreen(),
  '/info': (context) => const Information(),
//   // 'signUp': (context) => const SignupScreen(),
//   // 'login': (context) => const LoginScreen(),
//   // 'forgetPassword': (context) => const ForgotPassword(),
//   // 'userInformation': (context) => const UserInformation(),
//   'home': (context) => const Home(),
//   'mate': (context) => const Matches(),
//   'edit': (context) => const EditAndView(),
//   // 'answer': (context) => const Answer(),
//   'prompts': (context) => Prompts(),
//   'adopt': (context) => const Adopt(),
//   'pets': (context) => const Pets(),
//   'donate': (context) => const Donate(),
};
