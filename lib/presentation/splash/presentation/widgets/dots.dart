import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class Dots extends StatelessWidget {
  const Dots({super.key});

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return Stack(
      children: [
        //left
        Positioned(
          top: height * 0.30,
          left: width * 0.20,
          child: CircleAvatar(
            radius: width * 0.05,
            backgroundColor: MyColors.secondary,
          ),
        ),

        Positioned(
          top: height * 0.85,
          left: width * 0.20,
          child: CircleAvatar(
            radius: width * 0.05,
            backgroundColor: MyColors.secondary,
          ),
        ),

        Positioned(
          top: height * 0.52,
          left: width * 0.10,
          child: CircleAvatar(
            radius: width * 0.07,
            backgroundColor: MyColors.secondary,
          ),
        ),

        //right
        Positioned(
          top: height * 0.65,
          right: width * 0.16,
          child: CircleAvatar(
            radius: width * 0.07,
            backgroundColor: MyColors.secondary,
          ),
        ),

        Positioned(
          top: height * 0.15,
          right: width * 0.13,
          child: CircleAvatar(
            radius: width * 0.07,
            backgroundColor: MyColors.secondary,
          ),
        ),

        Positioned(
          top: height * 0.77,
          right: width * 0.12,
          child: CircleAvatar(
            radius: width * 0.04,
            backgroundColor: MyColors.secondary,
          ),
        ),
      ],
    );
  }
}
