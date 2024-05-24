import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/main_component.dart';

import 'Choices/choice.dart';
import 'Messages/chats.dart';
import 'Profile/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
      Choice(),
      const Chats(),
      const Profile(),
    ];

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: black),
      child: SafeArea(
        child: Scaffold(
          body: pages[selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: green,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/home.svg",
                    color: selectedIndex == 0 ? Colors.white : Colors.grey),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/chat.svg",
                    color: selectedIndex == 1 ? Colors.white : Colors.grey),
                label: "Matches",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/profile.svg",
                    color: selectedIndex == 2 ? Colors.white : Colors.grey),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
