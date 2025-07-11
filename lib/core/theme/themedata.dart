import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/theme/myfonts.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class Themedata {
  Themedata._();

  static ThemeData lightTheme(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    return ThemeData(
      // colorScheme: ColorScheme.fromSeed(seedColor: MyColors.black()),
      scaffoldBackgroundColor: MyColors.primary,
      useMaterial3: true,
      primaryColor: MyColors.primary,
      primaryIconTheme: IconThemeData(color: MyColors.black),
      textTheme: MyFonts.blackTextTheme(),

      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.all(MyColors.secondary),
        ),
      ),
      iconTheme: IconThemeData(color: MyColors.secondaryDense),
      listTileTheme: ListTileThemeData(
        textColor: MyColors.black,
        iconColor: MyColors.secondaryDense,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: MyColors.black,
          fontSize: width * 0.047,
          fontFamily: MyFonts.assetsFontFamily(),
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: MyColors.primary,
        iconTheme: IconThemeData(color: MyColors.black),
        scrolledUnderElevation: 0.0,
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    return ThemeData(
      // colorScheme: ColorScheme.fromSeed(seedColor: MyColors.white()),
      scaffoldBackgroundColor: MyColors.darkPrimary,
      useMaterial3: true,
      primaryColor: MyColors.darkPrimary,
      primaryIconTheme: IconThemeData(color: MyColors.white),
      textTheme: MyFonts.whiteTextTheme(),
      iconTheme: IconThemeData(),
      listTileTheme: ListTileThemeData(
        textColor: MyColors.white,
        iconColor: MyColors.secondary,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.all(MyColors.secondary),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: MyColors.darkPrimary,
        titleTextStyle: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: MyColors.white,
          fontSize: width * 0.047,
          fontFamily: MyFonts.assetsFontFamily(),
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: MyColors.black),
        scrolledUnderElevation: 0.0,
      ),
    );
  }
}
