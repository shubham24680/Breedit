import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_component.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: background,
    appBarTheme: AppBarTheme(
      backgroundColor: black,
      surfaceTintColor: black,
      centerTitle: true,
      titleTextStyle: GoogleFonts.manrope(
        color: white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: white,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: black,
      selectionColor: green.withOpacity(0.5),
      selectionHandleColor: green,
    ),
  );
}
