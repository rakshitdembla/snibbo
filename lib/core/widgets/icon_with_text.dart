import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';

class IconWithText extends StatelessWidget {
  final double height;
  final IconData icon;
  final String text;
  final GestureTapCallback onTap;
  const IconWithText({
    super.key,
    required this.height,
    required this.icon,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: MyColors.white,
            size: height * 0.0275,
          ),
          SizedBox(height: height * (0.002)),
          Text(
            text,
            style: TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.w500,
              fontSize: height * 0.014,
            ),
          ),
        ],
      ),
    );
  }
}
