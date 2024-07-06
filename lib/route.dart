import 'package:flutter/material.dart';

import 'OnboardingScreen/onboarding_screen.dart';
import 'Authentication/Phone Number/phone_number.dart';
import 'Authentication/Email/signup.dart';
import 'Authentication/Email/forgot_password.dart';
import 'Authentication/Email/login.dart';
import 'Information/User/user_info.dart';
import 'Information/User/User_Information.dart';
// import 'Information/Pet/pets_info.dart';
// import 'Information/Pet/pet_choice.dart';
// import 'Information/Pet/pet_name.dart';
// import 'Information/Pet/breed.dart';
// import 'Information/Pet/pet_gender.dart';
// import 'Information/Pet/pet_dob.dart';
// import 'Information/Pet/pet_profile_photo.dart';
// import 'Information/Pet/pet_about.dart';
import 'Home/home_info.dart';
import 'Home/home.dart';
import 'Home/Choices/Mate/matches.dart';
import 'Home/Choices/Mate/filter/edit.dart';
import 'Home/Choices/Mate/filter/answer.dart';
import 'Home/Choices/Adopt/adopt.dart';
import 'Home/Choices/Adopt/pets.dart';
// import 'Home/Profile/profile_edit.dart';

Map<String, WidgetBuilder> routes = {
  'onboarding': (context) => const OnboardingScreen(),
  'phoneNumber': (context) => const PhoneNumber(),
  'signUp': (context) => const SignupScreen(),
  'login': (context) => const LoginScreen(),
  'forgetPassword': (context) => const ForgotPassword(),
  'userInfo': (context) => const Information(),
  'userInformation': (context) => const UserInformation(),
  // 'name': (context) => const Name(),
  // 'dob': (context) => const DOB(),
  // 'gender': (context) => const Gender(),
  // 'petInfo': (context) => const PetsInfo(),
  // 'petChoice': (context) => const PetChoice(),
  // 'petName': (context) => const PetName(),
  // 'petBreed': (context) => const PetBreed(),
  // 'petDob': (context) => const PetDOB(),
  // 'petGender': (context) => const PetGender(),
  // 'petProfilePhoto': (context) => const PetProfilePhoto(),
  // 'petAbout': (context) => const PetAbout(),
  'homeInfo': (context) => const HomeInfo(),
  'home': (context) => const Home(),
  'mate': (context) => const Matches(),
  'edit': (context) => const EditAndView(),
  'answer': (context) => const Answer(),
  'adopt': (context) => const Adopt(),
  'pets': (context) => const Pets(),
  // 'editProfile': (context) => const EditProfile(),
};
