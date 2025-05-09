import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/user_story_widget.dart';

class MyStoryWidget extends StatelessWidget {
  final bool showBorder;
  final String profileUrl;
  final String username;
  final bool isDark;
  const MyStoryWidget({
    super.key,
    required this.username,
    required this.profileUrl,
    required this.showBorder,
    required this.isDark

  });

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return Padding(
      padding: EdgeInsets.only(left: width * 0.015),
      child: Column(
        children: [
          Stack(
            children: [
              UserStoryWidget(
                showBorder: showBorder,
                greyBorder: true,
                profileUrl: profileUrl,
                showComment: false,
                showLike: false,
                isMini: false,
                margins: EdgeInsets.fromLTRB(
                  width * 0.023,
                  height * 0.015,
                  width * 0.023,
                  height * 0.004,
                ),
                storySize: 0.10,
              ),
              Positioned(
                left: width * 0.16,
                top: height * 0.085,
                child: CircleAvatar(
                  radius: height * 0.014,
                  backgroundColor:
                      isDark ? MyColors.darkPrimary : MyColors.primary,
                  child: CircleAvatar(
                      radius: height * 0.012,
                      backgroundColor:
                          isDark ? MyColors.primary : MyColors.darkPrimary,
                      child: Icon(
                        Icons.add,
                        size: height * 0.02,
                        color: isDark ? MyColors.darkPrimary : MyColors.primary,
                      ),
                    ),
                  
                ),
              ),
            ],
          ),
          Text(username, style: TextStyle(fontSize: height * 0.013,color: MyColors.darkRefresh)),
        ],
      ),
    );
  }
}
