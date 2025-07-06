import 'package:flutter/material.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class PostActionIcon extends StatelessWidget {
  final String count;
  final Widget icon;
  final GestureTapCallback onTap;
  const PostActionIcon({
    super.key,
    required this.count,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          SizedBox(width: width * 0.009),
          Text(count, style: TextStyle(   overflow: TextOverflow.ellipsis,fontSize: width * 0.045)),
        ],
      ),
    );
  }
}
