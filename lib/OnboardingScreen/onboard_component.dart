import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main_component.dart';

_launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception("Could not launch $uri");
  }
}

TextSpan textButton(String text, String url) {
  return TextSpan(
    text: text,
    recognizer: TapGestureRecognizer()..onTap = () => _launchURL(url),
    style: GoogleFonts.quicksand(
      color: white,
      fontWeight: FontWeight.w900,
      decoration: TextDecoration.underline,
    ),
  );
}

class CElevatedButton extends StatelessWidget {
  const CElevatedButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.route,
  });

  final String text;
  final Color backgroundColor;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: ElevatedButton.styleFrom(
          foregroundColor: white,
          backgroundColor: backgroundColor,
          shadowColor: Colors.transparent,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          )),
      child: Text(
        text,
        style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: white),
      ),
    );
  }
}
