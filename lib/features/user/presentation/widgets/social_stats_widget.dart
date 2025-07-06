import 'package:flutter/material.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class SocialStatsWidget extends StatelessWidget {
  final String count;
  final String title;
  final GestureTapCallback onTap;
  const SocialStatsWidget({super.key,required this.count,required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
        final width = UiUtils.screenWidth(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(count,style: TextStyle(   overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w600,
            fontSize: width * 0.04
          ),),
          Text(title,style: TextStyle(   overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w500,
            fontSize: width * 0.03
          ),),
        ],
      ),
    );
  }
}