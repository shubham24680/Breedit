import 'package:flutter/material.dart';

import 'OnboardingScreen/onboarding_screen.dart';
import 'Authentication/Phone Number/phone_number.dart';
import 'Authentication/Email/signup.dart';
import 'Authentication/Email/forgot_password.dart';
import 'Authentication/Email/login.dart';
import 'Information/User/user_info.dart';
import 'Information/User/User_Information.dart';
import 'Home/home.dart';
import 'Home/Choices/Mate/matches.dart';
import 'Home/Choices/Mate/filter/edit.dart';
import 'Home/Choices/Mate/filter/answer.dart';
import 'Home/Choices/Adopt/adopt.dart';
import 'Home/Choices/Adopt/pets.dart';
import 'Home/Choices/donate.dart';

Map<String, WidgetBuilder> routes = {
  'onboarding': (context) => const OnboardingScreen(),
  'phoneNumber': (context) => const PhoneNumber(),
  // 'signUp': (context) => const SignupScreen(),
  // 'login': (context) => const LoginScreen(),
  // 'forgetPassword': (context) => const ForgotPassword(),
  'userInfo': (context) => const Information(),
  'userInformation': (context) => const UserInformation(),
  'home': (context) => const Home(),
  'mate': (context) => const Matches(),
  'edit': (context) => const EditAndView(),
  'answer': (context) => const Answer(),
  'adopt': (context) => const Adopt(),
  'pets': (context) => const Pets(),
  'donate': (context) => const Donate(),
};
