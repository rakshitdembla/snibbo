import 'package:flutter/material.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class MyListtile extends StatelessWidget {
  final String leadingTitle;
  final Widget trailingWidget;
  final GestureTapCallback? onTap;
  const MyListtile({
    super.key,
    required this.leadingTitle,
    required this.trailingWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    return ListTile(
      onTap: onTap ?? () {},
      contentPadding: EdgeInsets.symmetric(horizontal: width * 0.035),
      leading: Text(
        leadingTitle,
        style: TextStyle(   overflow: TextOverflow.ellipsis,fontSize: width * 0.045, fontWeight: FontWeight.w600),
      ),
      trailing: trailingWidget,
    );
  }
}
