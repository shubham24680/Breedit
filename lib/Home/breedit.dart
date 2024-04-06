import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_component.dart';

class Breedit extends StatefulWidget {
  const Breedit({super.key});

  @override
  State<Breedit> createState() => _BreeditState();
}

class _BreeditState extends State<Breedit> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) async => await getData());

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/home.svg", height: 100),
        ],
      ),
    );
  }
}