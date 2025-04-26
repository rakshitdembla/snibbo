import 'package:flutter/material.dart';

class MyColors {
  MyColors._();

  // Light Theme Colors
static const LinearGradient gradient = LinearGradient(
  colors: [
    Color(0xFF00C6FF), 
    Color(0xFF0072FF),
    Color(0xFF5B00FF), 
    Color(0xFF0047FF),
    Color(0xFF0026FF), 
    Color(0xFF0011FF), 
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
);

  static const Color primary = Colors.white;
  static const Color secondary = Color(0xFF339CFF);
  static const Color secondaryLight = Color(0xFF8DCDFF);
  static const Color secondaryUltraLight = Color(0xFFE0F2FF);
  static const Color secondaryDense = Color(0xFF0077CC);
  static const Color lowOpacitySecondary = Color.fromARGB(118, 117, 117, 117);
  static const Color refresh = Color.fromARGB(255, 85, 85, 85);
  static const Color grey = Color.fromARGB(255, 117, 117, 117);
  static const Color secondaryGrey = Color.fromARGB(255, 226, 226, 226);
  static const Color textFields = Color.fromARGB(87, 208, 235, 255);
  static const Color borders = Color.fromARGB(161, 64, 123, 160);

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF1C1C1E);
  static const Color darkSecondary = Color(0xFF339CFF);
  static const Color darkSecondaryLight = Color(0xFF3C8DCB);
  static const Color darkSecondaryUltraLight = Color(0xFF2E3A47);
  static const Color darkSecondaryDense = Color(0xFF005B99);
  static const Color darkLowOpacitySecondary = Color.fromARGB(80, 200, 200, 200);
  static const Color darkRefresh = Color.fromARGB(255, 180, 180, 180);
  static const Color darkGrey = Color(0xFF8E8E93);
  static const Color darkSecondaryGrey = Color(0xFF3A3A3C);
  static const Color darkTextFields = Color.fromARGB(22, 231, 245, 255);
  static const Color darkBorders = Color.fromARGB(255, 64, 123, 160);

  // Common Colors
  static const Color black = Colors.black;
  static const Color white = Colors.white;
}