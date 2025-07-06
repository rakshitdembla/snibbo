import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/elevated_cta.dart';
import 'package:snibbo_app/core/widgets/elevated_outlined_cta.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';
import 'package:snibbo_app/features/user/presentation/bloc/follow_user_bloc/follow_user_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/follow_user_bloc/follow_user_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/follow_user_bloc/follow_user_states.dart';
import 'package:snibbo_app/features/user/presentation/bloc/unfollow_user_bloc/unfollow_user_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/unfollow_user_bloc/unfollow_user_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/unfollow_user_bloc/unfollow_user_states.dart';
import 'package:snibbo_app/core/local_data_manager/follow_status_manager.dart';
import 'package:snibbo_app/features/user/presentation/widgets/social_stats_widget.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class UserInfoHeader extends StatefulWidget {
  final ProfileEntity profileEntity;
  const UserInfoHeader({super.key, required this.profileEntity});

  @override
  State<UserInfoHeader> createState() => _UserInfoHeaderState();
}

class _UserInfoHeaderState extends State<UserInfoHeader> {
  late ProfileEntity profile;
  @override
  void initState() {
    profile = widget.profileEntity;
    FollowStatusManager.isAlreadyFollwing[profile.username] =
        profile.isFollowedByMe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              UserCircularProfileWidget(
                isStatic: false,
                hasActiveStories: profile.hasActiveStories,
                isAllStoriesViewed: profile.viewedAllStories,
                profileUrl: profile.profilePicture,
                storySize: 0.11,
                username: profile.username,
                margins: EdgeInsets.zero,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.04),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.006),
                        child: Text(
                          profile.name,
                          style: TextStyle(   overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.035,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      SizedBox(
                        width: width * 0.60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SocialStatsWidget(
                              onTap: () {},
                              count: "${profile.posts}",
                              title: "posts",
                            ),
                            SocialStatsWidget(
                              onTap: () {
                                    FocusScope.of(context).unfocus();
                                context.router.push(
                                  UserConnectionsScreenRoute(
                                    username: profile.username,
                                    initialIndex: 0,
                                  ),
                                );
                              },
                              count: "${profile.userFollowers}",
                              title: "followers",
                            ),
                            SocialStatsWidget(
                              onTap: () {
                                    FocusScope.of(context).unfocus();
                                context.router.push(
                                  UserConnectionsScreenRoute(
                                    username: profile.username,
                                    initialIndex: 1,
                                  ),
                                );
                              },
                              count: "${profile.userFollowing}",
                              title: "following",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          profile.bio.isNotEmpty
              ? Padding(
                padding: EdgeInsetsGeometry.only(top: height * 0.01),
                child: SizedBox(width: width * 0.9, child: Text(profile.bio)),
              )
              : SizedBox.shrink(),
          SizedBox(height: height * 0.020),
          SizedBox(
            width: width * 0.90,
            child: BlocBuilder<FollowUserBloc, FollowUserStates>(
              builder: (context, followState) {
                return BlocBuilder<UnfollowUserBloc, UnfollowUserStates>(
                  builder: (context, unfollowState) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        profile.isMyProfile
                            ? ElevatedOutlinedCTA(
                              onPressed: () {
                                context.router.push(
                                  EditProfileScreenRoute(
                                    bio: profile.bio,
                                    name: profile.name,
                                    profileUrl:
                                        profile.profilePicture.toString(),
                                    username: profile.username,
                                  ),
                                );
                              },
                              buttonName: "Edit Profile",
                              isShort: true,
                            )
                            : !profile.isMyProfile &&
                                FollowStatusManager.isAlreadyFollwing[widget
                                        .profileEntity
                                        .username] ==
                                    true
                            ? ElevatedOutlinedCTA(
                              onPressed: () {
                                FollowStatusManager.isAlreadyFollwing[widget
                                        .profileEntity
                                        .username] =
                                    false;
                                BlocProvider.of<UnfollowUserBloc>(context).add(
                                  UnfollowRequested(username: profile.username),
                                );
                              },
                              buttonName: "Unfollow",
                              isShort: true,
                            )
                            : ElevatedCTA(
                              onPressed: () {
                                FollowStatusManager.isAlreadyFollwing[widget
                                        .profileEntity
                                        .username] =
                                    true;
                                BlocProvider.of<FollowUserBloc>(context).add(
                                  FollowRequested(username: profile.username),
                                );
                              },
                              buttonName: "Follow",
                              isShort: true,
                            ),
                        profile.isMyProfile
                            ? ElevatedOutlinedCTA(
                              onPressed: () {
                                ServicesUtils.copyLink(
                                  uniqueID: profile.username,
                                  type: "profile",
                                  context: context,
                                );
                              },
                              buttonName: "Share Profile",
                              isShort: true,
                            )
                            : ElevatedOutlinedCTA(
                              onPressed: () {
                                context.router.push(
                                  ChatScreenRoute(
                                    profilePicture: profile.profilePicture,
                                    username: profile.username,
                                    isOnline: profile.isOnline,
                                    lastSeen:
                                        profile.lastSeen != null
                                            ? DateFormat(
                                              'MMM d, yyyy • hh:mm a',
                                            ).format(profile.lastSeen!)
                                            : null,
                                  ),
                                );
                              },
                              buttonName: "Message",
                              isShort: true,
                            ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
