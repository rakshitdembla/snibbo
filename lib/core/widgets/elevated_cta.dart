import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/theme/myfonts.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class ElevatedCTA extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String buttonName;
  final bool isShort;
  const ElevatedCTA({
    super.key,
    required this.onPressed,
    required this.buttonName,
    required this.isShort,
  });

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return SizedBox(
      width: isShort ? width * 0.44 : width,
      height: isShort ? height * 0.04 : height * 0.055,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          backgroundColor: MyColors.secondary,
        ),
        onPressed: onPressed,
        child: Text(
          buttonName,
          style: TextStyle(
            fontFamily: MyFonts.assetsFontFamily(),
            color: MyColors.white,
            fontWeight: isShort ? FontWeight.w600 : FontWeight.w600,
            fontSize: isShort ? height * 0.0165 : height * 0.020,
          ),
        ),
      ),
    );
  }
}
