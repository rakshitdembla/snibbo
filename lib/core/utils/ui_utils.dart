import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:toastification/toastification.dart';

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

  static void showToast(
    String title,
    bool isDark,
    String description,
    BuildContext context,
  ) {
    final width = screenWidth(context);
    final height = screenWidth(context);
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? MyColors.white : MyColors.black,
          fontSize: width * 0.04,
        ),
      ),
      description: Text(
        description,
        style: TextStyle(color: MyColors.grey, fontSize: width * 0.03),
      ),
      alignment: Alignment.bottomCenter,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      icon: Icon(Icons.error_outline),
      showIcon: true,
      primaryColor: Colors.red,
      backgroundColor: isDark ? MyColors.darkPrimary : MyColors.primary,

      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.03,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.03,
      ),
      closeButton: ToastCloseButton(
        buttonBuilder:
            (context, onClose) => Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: onClose,
                child: Icon(
                  Icons.close,
                  size: width * 0.05,
                  color: const Color.fromARGB(133, 124, 123, 123),
                ),
              ),
            ),
      ),

      borderRadius: BorderRadius.circular(12.r),
      showProgressBar: true,
      progressBarTheme: ProgressIndicatorThemeData(
        linearTrackColor: MyColors.secondaryGrey,
        color: Colors.red,
        linearMinHeight: height * 0.004,
        borderRadius: BorderRadius.circular(50.r),
      ),
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      borderSide: BorderSide(
        width: 0,
        color: isDark ? MyColors.refresh : MyColors.darkPrimary,
      ),
    );
  }
}
