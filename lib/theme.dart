import 'package:flutter/material.dart';

import 'main_component.dart';

ThemeData theme() {
  return ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: black,
      selectionColor: green.withOpacity(0.5),
      selectionHandleColor: green,
    )
  );
}