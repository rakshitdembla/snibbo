import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/elevated_cta.dart';
import 'package:snibbo_app/core/widgets/elevated_outlined_cta.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';
import 'package:snibbo_app/features/user/presentation/widgets/social_stats_widget.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class UserInfoHeader extends StatelessWidget {
final ProfileEntity profileEntity;
  const UserInfoHeader({
    super.key,
required this.profileEntity
  });

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
              UserCircularProfileWidget(
                showBorder: profileEntity.hasActiveStories,
                greyBorder: profileEntity.viewedAllStories,
                profileUrl: profileEntity.profilePicture,
                storySize: 0.11,
                margins: EdgeInsets.zero,
              ),
              SizedBox(width: width * 0.04),
              SizedBox(
                height: height * 0.085,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profileEntity.name, style: TextStyle(fontWeight: FontWeight.w600,fontSize: width * 0.035)),
                    SizedBox(
                      width: width * 0.60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SocialStatsWidget(count: "${profileEntity.posts}", title: "posts"),
                          SocialStatsWidget(
                            count: "${profileEntity.userFollowers}",
                            title: "followers",
                          ),
                          SocialStatsWidget(
                            count: "${profileEntity.userFollowing}",
                            title: "following",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: width * 0.9,
            child: Text(
              profileEntity.bio,
              // "Chasing Gains & Some Good Vibes\nSad Boi Llalalalala\nCake Murderer\nBirthday 14-pril-2025",
            ),
          ),
          SizedBox(height: height * 0.020),
          SizedBox(
            width: width * 0.90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                profileEntity.isMyProfile
                    ? ElevatedOutlinedCTA(
                      onPressed: () {
                        context.router.push(
                          EditProfileScreenRoute(
                            bio: profileEntity.bio,
                            name: profileEntity.name,
                            profileUrl: profileEntity.profilePicture,
                            username: profileEntity.username,
                          ),
                        );
                      },
                      buttonName: "Edit Profile",
                      isShort: true,
                    )
                    : ElevatedCTA(
                      onPressed: () {},
                      buttonName: "Follow",
                      isShort: true,
                    ),
                profileEntity.isMyProfile
                    ? ElevatedOutlinedCTA(
                      onPressed: () {},
                      buttonName: "Share Profile",
                      isShort: true,
                    )
                    : ElevatedOutlinedCTA(
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
