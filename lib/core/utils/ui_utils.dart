import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class UiUtils {
  UiUtils._();

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static PersistentBottomNavBarItem navBarItem({
    required IconData icon,
    required IconData inactiveIcon,
    required BuildContext context,
  }) {
    final isDark = context.watch<ThemeBloc>().state is DarkThemeState;
    final width = UiUtils.screenWidth(context);
    return PersistentBottomNavBarItem(
      icon: Icon(icon, color: isDark ? MyColors.white : MyColors.black),
      inactiveIcon: Icon(
        inactiveIcon,
        color: isDark ? MyColors.white : MyColors.black,
      ),
      iconSize: width * 0.075,
    );
  }
}
