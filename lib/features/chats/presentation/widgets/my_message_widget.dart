import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class MyMessageWidget extends StatelessWidget {
  const MyMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Card(
          color: Color(0xFF0084FF),
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
      );""", style: TextStyle(color: MyColors.white)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.02,
            vertical: height * 0.008,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "15:05",
                style: TextStyle(
                  color: MyColors.secondaryGrey,
                  fontSize: height * 0.012,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: width * 0.012),
              Icon(
                Icons.done_all,
                size: height * 0.019,
                color: MyColors.secondaryGrey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
