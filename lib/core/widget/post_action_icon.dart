import 'package:flutter/material.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class PostActionIcon extends StatelessWidget {
  final String count;
  final IconData icon;
  final Color iconColor;
  const PostActionIcon({
    super.key,
    required this.count,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    return Row(
      children: [
        Icon(icon, color: iconColor, size: width * 0.07),
        SizedBox(width: width * 0.006,),
        Text(count, style: TextStyle(fontSize: width * 0.045)),
      ],
    );
  }
}
