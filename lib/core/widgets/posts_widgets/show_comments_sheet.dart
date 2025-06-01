import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/bottom_modal_sheet.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/user_comment_widget.dart';

class ShowCommentsSheet {
  static void show({required BuildContext context, required bool isDark}) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    MyBottomModalSheet.show(
      context: context,
      isDark: isDark,
      builder: (context) {
        return SizedBox(
          width: width,
          height: height * 0.6,
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.013),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Comments",
                  style: TextStyle(
                    fontSize: width * 0.037,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.0015),
                  child: Opacity(
                    opacity: 0.15,
                    child: Divider(
                      color: MyColors.grey,
                      thickness: 1.0.r,
                      radius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsetsGeometry.only(bottom: UiUtils.bottomNavBar(context: context)),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return UserCommentWidget(
                        commentContent: "hello, my self flutter dart",
                        isReply: false,
                        likes: 7,
                        profileUrl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjZirTv3YUaHSe-VVIQzwXUHXxb8mnJ-krbg&s",
                        timeAgo: DateTime.now(),
                        username: "rakshitdembla",replies: 1,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
