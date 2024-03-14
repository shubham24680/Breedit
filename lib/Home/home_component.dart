import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_component.dart';

heading(String text) {
  return Text(
    text,
    style: GoogleFonts.merriweather(
        color: black, fontSize: 32, fontWeight: FontWeight.w900),
  );
}
