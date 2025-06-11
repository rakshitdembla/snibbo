import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/theme/myfonts.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class MiniElevatedCTA extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String buttonName;

  const MiniElevatedCTA({
    super.key,
    required this.onPressed,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);

    return SizedBox(
      height: height * 0.033,
      width: width * 0.25,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
          side: BorderSide(
            color: const Color.fromARGB(124, 51, 156, 255),
            width: 1.r,
          ),
           backgroundColor: MyColors.secondary,
        ),
        onPressed: onPressed,
        child: Text(
          buttonName,
          style: TextStyle(
            fontFamily: MyFonts.assetsFontFamily(),
            fontWeight: FontWeight.w500,
            fontSize: height * 0.0145,
            color: MyColors.white,
          ),
        ),
      ),
    );
  }
}
