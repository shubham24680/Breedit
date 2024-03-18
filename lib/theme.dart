import 'package:flutter/material.dart';

import 'main_component.dart';

ThemeData theme() {
  return ThemeData(
    colorScheme: const ColorScheme.light(background: background),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: black,
      selectionColor: green.withOpacity(0.5),
      selectionHandleColor: green,
    )
  );
}