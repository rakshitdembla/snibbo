import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/theme/myfonts.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class TextSpanBottom extends StatelessWidget {
  final String title;
  final String actionTitle;
  final GestureTapCallback onTap;
  const TextSpanBottom({
    super.key,
    required this.actionTitle,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    return SafeArea(
      child: RichText(
        text: TextSpan(
          text: title,
          style: TextStyle(
            fontFamily: MyFonts.assetsFontFamily(),
            color: MyColors.grey,
            fontWeight: FontWeight.w600,
            fontSize: width * 0.04,
          ),
          children: [
            TextSpan(
              recognizer: TapGestureRecognizer()..onTap = onTap,
              text: actionTitle,
              style: TextStyle(
                fontFamily: MyFonts.assetsFontFamily(),
                color: MyColors.secondary,
                fontWeight: FontWeight.w700,
                fontSize: width * 0.04,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
