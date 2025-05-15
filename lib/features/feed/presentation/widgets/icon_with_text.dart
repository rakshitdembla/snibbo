import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';

class IconWithText extends StatelessWidget {
  final bool isDark;
  final double height;
  final IconData icon;
  final String text;
  final GestureTapCallback onTap;
  const IconWithText({
    super.key,
    required this.height,
    required this.icon,
    required this.isDark,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isDark ? MyColors.white : MyColors.black,
            size: height * 0.0275,
          ),
          SizedBox(height: height * (0.002)),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: height * 0.014,
            ),
          ),
        ],
      ),
    );
  }
}
