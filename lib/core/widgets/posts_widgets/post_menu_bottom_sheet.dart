import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/bottom_modal_sheet.dart';

class PostMenuBottomSheet {
  static void call({
    required BuildContext context,
    required bool isDark,
    required String postId,
  }) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    MyBottomModalSheet.show(
      isScrollControlled: true,
      context: context,
      isDark: isDark,
      builder: (context) {
        return SizedBox(
          height: height * 0.2,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: UiUtils.bottomNavBar(context: context),
              top: height * 0.02,
              left: width * 0.015,
              right: width * 0.015,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PostMenuSheetContainer._(
                  onTap: () {
                    Navigator.pop(context);
                    ServicesUtils.copyLink(
                      uniqueID: postId,
                      type: "post",
                      context: context,
                    );
                  },
                  height: height,
                  width: width,
                  isDark: isDark,
                  icon: LineIcons.link,
                  text: "Link",
                  color: MyColors.secondary,
                ),
                PostMenuSheetContainer._(
                  onTap: () {
                    Navigator.pop(context);
                    ServicesUtils.openEmailApp(
                      reportFor: "post",
                      uniqueID: postId,
                      context: context,
                      isReport: true,
                    );
                  },
                  height: height,
                  width: width,
                  isDark: isDark,
                  icon: LineIcons.exclamationCircle,
                  text: "Report",
                  color: Colors.red,
                ),
                PostMenuSheetContainer._(
                  onTap: () {
                       Navigator.pop(context);
                    ServicesUtils.openEmailApp(
                      reportFor: "",
                      uniqueID: postId,
                      context: context,
                      isReport: false,
                    );
                  },
                  height: height,
                  width: width,
                  isDark: isDark,
                  icon: LineIcons.headset,
                  text: "Contact Us",
                  color: isDark ? MyColors.primary : MyColors.darkPrimary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PostMenuSheetContainer extends StatelessWidget {
  final double height;
  final IconData icon;
  final String text;
  final Color color;
  final double width;
  final bool isDark;
  final GestureTapCallback onTap;
  const PostMenuSheetContainer._({
    required this.height,
    required this.width,
    required this.isDark,
    required this.onTap,
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.08,
        width: width * 0.27,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: height * 0.0275),
            SizedBox(height: height * (0.002)),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: height * 0.014,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
