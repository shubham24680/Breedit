import 'package:flutter/material.dart';
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
      const Choice(),
      const Chats(),
      const Profile(),
    ];

    return Scaffold(
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
                colorFilter: ColorFilter.mode(
                    selectedIndex == 0 ? white : grey, BlendMode.srcIn)),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/chat.svg",
                colorFilter: ColorFilter.mode(
                    selectedIndex == 1 ? white : grey, BlendMode.srcIn)),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/profile.svg",
                colorFilter: ColorFilter.mode(
                    selectedIndex == 2 ? white : grey, BlendMode.srcIn)),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
