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

  static const Color darkPrimary = Color(0xFF1C1C1E);
  static const Color darkRefresh = Color.fromARGB(255, 180, 180, 180);
  static const Color darkTextFields = Color.fromARGB(22, 231, 245, 255);
  
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color searchField =  Color.fromARGB(49, 161, 161, 161);
}
