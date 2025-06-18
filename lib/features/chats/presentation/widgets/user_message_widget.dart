import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class UserMessageWidget extends StatelessWidget {
  const UserMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Card(
          color: Color(0xFFFAF9F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.012,
              horizontal: width * 0.023,
            ),
            child: Text("""Card(
        color: isMyMessage ? Color(0kksk
        child: Padding(
          padding: const EdgeInsets.all(10), child: Text(
      message,
      style: TextStyle(
        color: isMyMessage ? Colors.white : Colors.black87,
      ),
          ),
        ),
      );""", style: TextStyle(color: MyColors.black)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.027,
            vertical: height * 0.008,
          ),
          child: Text(
            "15:05",
            style: TextStyle(
              color: MyColors.refresh,
              fontSize: height * 0.012,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
