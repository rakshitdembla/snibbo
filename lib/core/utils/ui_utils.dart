import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  static void errorToast(String title,bool isDark,String description,BuildContext context) {
    toastification.show(
  type: ToastificationType.error,
  style: ToastificationStyle.flat,
  autoCloseDuration: const Duration(seconds: 2),
  title: Text(title,style: TextStyle(
    color: isDark ? MyColors.white : MyColors.black, fontSize: screenWidth(context) * 0.03
  ),),
  description: Text(description,style: TextStyle(
    color: MyColors.grey,
    fontSize: screenWidth(context) * 0.02
  ),),
  alignment: Alignment.topRight,
  direction: TextDirection.ltr,
  animationDuration: const Duration(milliseconds: 300),
  animationBuilder: (context, animation, alignment, child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  },
  icon: Icon(Icons.check,),
  showIcon: true, 
  primaryColor: Colors.green,
  backgroundColor: isDark ? MyColors.darkPrimary :  MyColors.primary,
  foregroundColor: Colors.black,
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  borderRadius: BorderRadius.circular(12),
  boxShadow: const [
    BoxShadow(
      color: Color(0x07000000),
      blurRadius: 16,
      offset: Offset(0, 16),
      spreadRadius: 0,
    )
  ],
  showProgressBar: true,
  closeButton: ToastCloseButton(
    showType: CloseButtonShowType.onHover,
    buttonBuilder: (context, onClose) {
      return OutlinedButton.icon(
        onPressed: onClose,
        icon: const Icon(Icons.close, size: 20),
        label: const Text('Close'),
      );
    },
  ),
  closeOnClick: false,
  pauseOnHover: true,
  dragToClose: true,
  applyBlurEffect: true,
  // callbacks: ToastificationCallbacks(
  // ),
);
  } 
}
