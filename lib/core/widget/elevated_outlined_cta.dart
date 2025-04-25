import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/theme/myfonts.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class ElevatedOutlinedCTA extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String buttonName;
  const ElevatedOutlinedCTA({
    super.key,
    required this.onPressed,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return SizedBox(
      width: width,
      height: height * 0.055,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: MyColors.black,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: MyColors.white,
        ),
        onPressed: onPressed,
        child: Text(
          buttonName,
          style: TextStyle(
            fontFamily: MyFonts.assetsFontFamily(),
            color: MyColors.black,
            fontWeight: FontWeight.w900,
            fontSize: height * 0.020,
          ),
        ),
      ),
    );
  }
}
