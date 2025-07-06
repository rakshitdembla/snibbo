import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/theme/myfonts.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class H1H2Title extends StatelessWidget {
  final String h1;
  final String h2;
  const H1H2Title({super.key, required this.h1, required this.h2});

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          h1,
          style: TextStyle(   overflow: TextOverflow.ellipsis,
            fontSize: width * 0.055,
            fontWeight: FontWeight.w600,
            fontFamily: MyFonts.assetsFontFamily(),
          ),
        ),
        SizedBox(height: height * 0.0020),
        Text(
          h2,
          style: TextStyle(   overflow: TextOverflow.ellipsis,
            fontSize: width * 0.037,
            fontWeight: FontWeight.w500,
            color: MyColors.grey,
          ),
        ),
      ],
    );
  }
}
