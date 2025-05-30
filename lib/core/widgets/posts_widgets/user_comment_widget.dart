import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class UserCommentWidget extends StatelessWidget {
  final String profileUrl;
  final String username;
  final bool isReply;
  final int likes;
  final String commentContent;
  final DateTime timeAgo;
  final int replies;
  const UserCommentWidget({
    super.key,
    required this.commentContent,
    required this.isReply,
    required this.likes,
    required this.profileUrl,
    required this.timeAgo,
    required this.username,
    required this.replies,
  });

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserCircularProfileWidget(
            profileUrl: profileUrl,
            margins: EdgeInsets.only(right: width * 0.016),
            storySize: 0.04,
            greyBorder: false,
            showBorder: false,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.013,
                      ),
                    ),
                    Text(
                      "  ${ServicesUtils.toTimeAgo(timeAgo)}",
                      style: TextStyle(
                        color: MyColors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: height * 0.011,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.0018),
                Text(
                  commentContent,
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: height * 0.0145,
                  ),
                ),
                SizedBox(height: height * 0.003),
                Text(
                  "Reply",
                  style: TextStyle(
                    color: MyColors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: height * 0.012,
                  ),
                ),
                replies > 0
                    ? Padding(
                      padding: EdgeInsets.only(left: width * 0.005),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.01),
                          Text(
                            "- View $replies more reply",
                            style: TextStyle(
                              color:
                                  isDark
                                      ? MyColors.darkRefresh
                                      : MyColors.refresh,
                              fontWeight: FontWeight.w500,
                              fontSize: height * 0.012,
                            ),
                          ),
                        ],
                      ),
                    )
                    : SizedBox.shrink(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.02,
              right: width * 0.01,
              left: width * 0.05,
            ),
            child: Column(
              children: [
                Icon(
                  LineIcons.heart,
                  color: isDark ? MyColors.primary : MyColors.darkPrimary,
                  size: height * 0.018,
                ),
                SizedBox(height: height * 0.006),
                Text(
                  likes.toString(),
                  style: TextStyle(
                    fontSize: width * 0.025,
                    color: MyColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
