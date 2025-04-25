import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class OnBoardDots extends StatelessWidget {
  final String centerImagePath;
  final String leftImage1Path;
  final String leftImage2Path;
  final String leftImage3Path;
  final String rightImage1Path;
  final String rightImage2Path;
  final String rightImage3Path;

  const OnBoardDots({
    super.key,
    required this.centerImagePath,
    required this.leftImage1Path,
    required this.leftImage2Path,
    required this.leftImage3Path,
    required this.rightImage1Path,
    required this.rightImage2Path,
    required this.rightImage3Path,
  });

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return Stack(
      children: [
        //center
        Positioned(
          top: height * 0.10,
          left: 0,
          right: 0,
          child: CircleAvatar(
            radius: width * 0.25,
            backgroundColor: MyColors.secondaryUltraLight,
            child: Image.asset(
              centerImagePath,
              fit: BoxFit.fill,
              height: width * 0.4,
              width: width * 0.4,
            )
          ),
        ),
        //left
        Positioned(
          top: height * 0.07,
          left: width * 0.05,
          child: CircleAvatar(
            radius: width * 0.05,
            backgroundColor: MyColors.secondary,
            child: Image.asset(
              leftImage1Path,
              fit: BoxFit.fill,
              height: width * 0.07,
              width: width * 0.07,
            ),
          ),
        ),
        Positioned(
          top: height * 0.25,
          left: width * 0.01,
          child: CircleAvatar(
            radius: width * 0.08,
            backgroundColor: MyColors.secondaryUltraLight,
            child: Image.asset(
              leftImage2Path,
              fit: BoxFit.fill,
              height: width * 0.11,
              width: width * 0.11,
            ),
          ),
        ),

        Positioned(
          top: height * 0.395,
          left: width * 0.20,
          child: CircleAvatar(
            radius: width * 0.06,
            backgroundColor: MyColors.secondaryLight,
            child: Image.asset(
              leftImage3Path,
              fit: BoxFit.fill,
              height: width * 0.09,
              width: width * 0.09,
            ),
          ),
        ),
        //right
        Positioned(
          top: height * 0.04,
          right: width * 0.07,
          child: CircleAvatar(
            radius: width * 0.09,
            backgroundColor: MyColors.secondaryUltraLight,
            child: Image.asset(
              rightImage1Path,
              fit: BoxFit.fill,
              height: width * 0.15,
              width: width * 0.15,
            ),
          ),
        ),
        Positioned(
          top: height * 0.22,
          right: width * 0.01,
          child: CircleAvatar(
            radius: width * 0.05,
            backgroundColor: MyColors.secondary,
            child: Image.asset(
              rightImage2Path,
              fit: BoxFit.fill,
              height: width * 0.07,
              width: width * 0.07,
            ),
          ),
        ),

        Positioned(
          top: height * 0.35,
          right: width * 0.08,
          child: CircleAvatar(
            radius: width * 0.08,
            backgroundColor: MyColors.secondaryLight,
            child: Image.asset(
              rightImage3Path,
              fit: BoxFit.fill,
              height: width * 0.12,
              width: width * 0.12,
            ),
          ),
        ),
      ],
    );
  }
}
