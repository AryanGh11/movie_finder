import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  // General
  useMaterial3: true,

  // Style
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 230, 170, 27),
      foregroundColor: const Color.fromARGB(255, 47, 47, 47),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      disabledBackgroundColor: const Color.fromARGB(255, 81, 81, 81),
      disabledForegroundColor: const Color.fromARGB(100, 255, 255, 255),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Color.fromARGB(255, 18, 18, 18),
    labelStyle: TextStyle(color: Colors.white),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white)),
  ),

  // Color
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
    brightness: Brightness.dark,
    surface: const Color.fromARGB(255, 20, 20, 20),
    onSurface: Colors.white,
    secondary: const Color.fromARGB(255, 30, 30, 30),
    primary: const Color.fromARGB(255, 230, 170, 27),
  ),
);
