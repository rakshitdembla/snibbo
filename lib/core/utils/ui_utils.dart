import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:toastification/toastification.dart';

class UiUtils {
  UiUtils._();

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
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

  static Widget showShimmerBuilder({
    required wasSynchronouslyLoaded,
    required frame,
    required child,
  }) {
    if (wasSynchronouslyLoaded || frame != null) {
      return child;
    } else {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(color: Colors.grey[300]),
      );
    }
  }

  static Widget showShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(color: Colors.grey[300]),
    );
  }

}
