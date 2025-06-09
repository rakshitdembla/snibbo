import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:snibbo_app/features/user/presentation/widgets/follow_status_manager.dart';
import 'package:snibbo_app/features/user/presentation/widgets/social_stats_widget.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class UserInfoHeader extends StatefulWidget {
  final ProfileEntity profileEntity;
  const UserInfoHeader({super.key, required this.profileEntity});

  @override
  State<UserInfoHeader> createState() => _UserInfoHeaderState();
}

class _UserInfoHeaderState extends State<UserInfoHeader> {
  @override
  void initState() {
    FollowStatusManager.isAlreadyFollwing[widget.profileEntity.username] =
        widget.profileEntity.isFollowedByMe;
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
                showBorder: widget.profileEntity.hasActiveStories,
                greyBorder: widget.profileEntity.viewedAllStories,
                profileUrl: widget.profileEntity.profilePicture,
                storySize: 0.11,
                margins: EdgeInsets.zero,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.04),
                child: SizedBox(
                  height: height * 0.085,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.006),
                        child: Text(
                          widget.profileEntity.name,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
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
                              count: "${widget.profileEntity.posts}",
                              title: "posts",
                            ),
                            SocialStatsWidget(
                              count: "${widget.profileEntity.userFollowers}",
                              title: "followers",
                            ),
                            SocialStatsWidget(
                              count: "${widget.profileEntity.userFollowing}",
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
          widget.profileEntity.bio.isNotEmpty
              ? Padding(
              padding: EdgeInsetsGeometry.only(top: height * 0.01),
                child: SizedBox(
                  width: width * 0.9,
                  child: Text(widget.profileEntity.bio),
                ),
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
                        widget.profileEntity.isMyProfile
                            ? ElevatedOutlinedCTA(
                              onPressed: () {
                                context.router.push(
                                  EditProfileScreenRoute(
                                    bio: widget.profileEntity.bio,
                                    name: widget.profileEntity.name,
                                    profileUrl:
                                        widget.profileEntity.profilePicture,
                                    username: widget.profileEntity.username,
                                  ),
                                );
                              },
                              buttonName: "Edit Profile",
                              isShort: true,
                            )
                            : !widget.profileEntity.isMyProfile &&
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
                                  UnfollowRequested(
                                    username: widget.profileEntity.username,
                                  ),
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
                                  FollowRequested(
                                    username: widget.profileEntity.username,
                                  ),
                                );
                              },
                              buttonName: "Follow",
                              isShort: true,
                            ),
                        widget.profileEntity.isMyProfile
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
