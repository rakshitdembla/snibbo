import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/theme/myfonts.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class OnBoardPage extends StatelessWidget {
  final Widget onBoardDots;
  final String h1;
  final String h2;
  const OnBoardPage({super.key,required this.h1,required this.h2,required this.onBoardDots});

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width,
            height: height * 0.50,
            child: onBoardDots
          ),
          Text(
            h1,
            style: TextStyle(
              fontFamily: MyFonts.assetsFontFamily(),
              fontSize: width * 0.07,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: height * 0.0045),
          Text(
          h2,
            style: TextStyle(
              fontFamily: MyFonts.assetsFontFamily(),
              fontSize: width * 0.042,
              fontWeight: FontWeight.w400,
              color: MyColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}