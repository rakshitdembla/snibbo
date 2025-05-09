import 'package:flutter/material.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/elevated_cta.dart';
import 'package:snibbo_app/core/widgets/elevated_outlined_cta.dart';
import 'package:snibbo_app/core/widgets/user_story_widget.dart';
import 'package:snibbo_app/features/user/presentation/widgets/social_stats_widget.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UserStoryWidget(
                showBorder: false,
                greyBorder: false,
                isMini: false,
                showComment: false,
                showLike: false,
                profileUrl: MyAssets.demoUser,
                storySize: 0.05,
                margins: EdgeInsets.zero,
              ),
              SizedBox(width: width * 0.04),
              SizedBox(
                height: height * 0.085,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rakshit Dembla",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: width * 0.60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SocialStatsWidget(count: "50", title: "posts"),
                          SocialStatsWidget(count: "1000", title: "followers"),
                          SocialStatsWidget(count: "852", title: "following"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.01),
          SizedBox(
            width: width * 0.9,
            child: Text(
              "Chasing Gains & Some Good Vibes\nSad Boi Llalalalala\nCake Murderer\nBirthday 14-pril-2025",
            ),
          ),
          SizedBox(height: height * 0.020),
          SizedBox(
            width: width * 0.90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedCTA(
                  onPressed: () {},
                  buttonName: "Follow",
                  isShort: true,
                ),
                ElevatedOutlinedCTA(
                  onPressed: () {},
                  buttonName: "Message",
                  isShort: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
