import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';

class MyFonts {
  MyFonts._();

  static TextTheme blackTextTheme() {
    return GoogleFonts.poppinsTextTheme()
        .apply(bodyColor: MyColors.black);
  }

  static TextTheme whiteTextTheme() {
    return GoogleFonts.poppinsTextTheme()
        .apply(bodyColor: MyColors.white);
  }

  static String assetsFontFamily() {
    return "poppinsBold";
  }
}
