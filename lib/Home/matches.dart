import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Matches extends StatelessWidget {
  const Matches({super.key});

  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset("assets/icons/heart.svg", height: 100),
    );
  }
}
