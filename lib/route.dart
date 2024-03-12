import 'package:flutter/material.dart';

import 'Authentication/create_account.dart';
import 'Information/User/dob.dart';
import 'Information/User/gender.dart';
import 'Information/User/name.dart';
import 'Information/User/profile_photo.dart';
import 'Information/User/user_info.dart';
import 'Information/Pet/pets_info.dart';
import 'Information/Pet/pet_name.dart';
import 'Information/Pet/pet_gender.dart';
import 'Information/Pet/pet_dob.dart';
import 'Information/Pet/pet_profile_photo.dart';
import 'Home/home.dart';

Map<String, WidgetBuilder> routes = {
  'createAccount': (context) => const CreateAccount(),
  'userInfo': (context) => const UserInformation(),
  'name': (context) => const Name(),
  'dob': (context) => const DOB(),
  'gender': (context) => const Gender(),
  'profilePhoto': (context) => const ProfilePhoto(),
  'petInfo': (context) => const PetsInfo(),
  'petName': (context) => const PetName(),
  'petDob': (context) => const PetDOB(),
  'petGender': (context) => const PetGender(),
  'petProfilePhoto': (context) => const PetProfilePhoto(),
  'home': (context) => const Home(),
};
