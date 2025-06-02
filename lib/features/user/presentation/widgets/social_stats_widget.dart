import 'package:flutter/material.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class SocialStatsWidget extends StatelessWidget {
  final String count;
  final String title;
  const SocialStatsWidget({super.key,required this.count,required this.title});

  @override
  Widget build(BuildContext context) {
        final width = UiUtils.screenWidth(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(count,style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: width * 0.04
        ),),
        Text(title,style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: width * 0.03
        ),),
      ],
    );
  }
}