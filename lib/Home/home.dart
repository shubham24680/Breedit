import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/main_component.dart';
import 'home_component.dart';
import '/Home/breedit.dart';
import '/Home/reddit.dart';
import '/Home/matches.dart';
import '/Home/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    const List<Widget> pages = <Widget>[
      Breedit(),
      Reddit(),
      Matches(),
      Profile(),
    ];

    return SafeArea(
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
              icon: SvgPicture.asset("assets/icons/star.svg",
                  color: selectedIndex == 1 ? Colors.white : Colors.grey),
              label: "Star",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/heart.svg",
                  color: selectedIndex == 2 ? Colors.white : Colors.grey),
              label: "Matches",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/profile.svg",
                  color: selectedIndex == 3 ? Colors.white : Colors.grey),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
