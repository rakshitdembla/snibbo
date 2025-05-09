import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
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

  static void showToast({
    required String title,
    required bool isDark,
    required String description,
    required BuildContext context,
    required bool isSuccess,
    required bool isWarning,
  }) {
    final width = screenWidth(context);
    final height = screenWidth(context);
    toastification.show(
      type:
          isSuccess
              ? ToastificationType.success
              : isWarning
              ? ToastificationType.warning
              : ToastificationType.error,
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
      icon: Icon(
        isSuccess
            ? Icons.check
            : isWarning
            ? Icons.warning_outlined
            : Icons.error_outline,

        size: width * 0.06,
      ),
      showIcon: true,
      primaryColor:
          isSuccess
              ? Colors.green
              : isWarning
              ? Colors.orange
              : Colors.red,
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
        color:
            isSuccess
                ? Colors.green
                : isWarning
                ? Colors.orange
                : Colors.red,
        linearMinHeight: height * 0.004,
        borderRadius: BorderRadius.circular(50.r),
      ),
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
      borderSide: BorderSide(
        width: 0,
        color: isDark ? MyColors.refresh : MyColors.darkPrimary,
      ),
    );
  }

  static void showBottomSheet({
    required BuildContext context,
    required bool isDark,
    required String h1,
    required String h2,
    required GestureTapCallback cameraSourceTap,
    required GestureTapCallback gallerySourceTap
  }) {
    final height = screenHeight(context);
    final width = screenWidth(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? MyColors.darkPrimary : MyColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      isDismissible: true,
      builder: (context) {
        return SizedBox(
          height: height * 0.6,

          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        MyAssets.storyImage,
                        height: height * 0.3,
                        width: width,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        left: width * 0.92,
                        top: height * 0.01,
                        child: InkWell(
                          onTap: () {
                             Navigator.pop(context); 
                          },
                          child: Icon(
                              Icons.cancel_outlined,
                              size: height * 0.03,
                              color: MyColors.white,
                            ),
                        ),
                       
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.025,
                    vertical: height * 0.01,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        h1,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: height * 0.03,
                        ),
                      ),

                      SizedBox(height: height * 0.004),
                      Text(
                        h2,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: MyColors.grey,
                          fontSize: height * 0.018,
                        ),
                      ),
                    ],
                  ),
                ),
                StorySourceTile(
                  icon: Icons.camera_alt_outlined,
                  title: "Camera",
                  onTap: cameraSourceTap,
                ),
                StorySourceTile(
                  icon: Icons.image_outlined,
                  title: "Gallery",
                  onTap: gallerySourceTap,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StorySourceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final GestureTapCallback onTap;
  const StorySourceTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: UiUtils.screenHeight(context) * 0.035),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: UiUtils.screenHeight(context) * 0.021,
        ),
      ),
    );
  }
}
