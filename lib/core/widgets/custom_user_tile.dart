import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/mini_elevated_cta.dart';
import 'package:snibbo_app/core/widgets/mini_elevated_outline_cta.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/user/presentation/bloc/follow_user_bloc/follow_user_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/follow_user_bloc/follow_user_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/unfollow_user_bloc/unfollow_user_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/unfollow_user_bloc/unfollow_user_events.dart';
import 'package:snibbo_app/core/local_data_manager/follow_status_manager.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class CustomUserTile extends StatefulWidget {
  final UserEntity user;
  const CustomUserTile({super.key, required this.user});

  @override
  State<CustomUserTile> createState() => _CustomUserTileState();
}

class _CustomUserTileState extends State<CustomUserTile> {
  @override
  void initState() {
    super.initState();
    FollowStatusManager.isAlreadyFollwing.putIfAbsent(
      widget.user.username,
      () => widget.user.isFollowedByMe ?? false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final user = widget.user;
    final isMySelf = user.isMyself == true;
    final isFollowedByMe =
        FollowStatusManager.isAlreadyFollwing[user.username] == true;

    final height = UiUtils.screenHeight(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.009,
      ),
      child: Row(
        children: [
          UserCircularProfileWidget(
            isStatic: false,
            profileUrl: user.profilePicture,
            margins: EdgeInsets.zero,
            username: user.username,
            storySize: 0.06,
            isAllStoriesViewed: user.isAllStoriesViewed,
            hasActiveStories: user.hasActiveStories,
          ),
          SizedBox(width: width * 0.022),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              isMySelf
                  ? context.router.push(ProfileScreenRoute())
                  : context.router.push(
                    UserProfileScreenRoute(username: user.username),
                  );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: TextStyle(   overflow: TextOverflow.ellipsis,
                    fontSize: height * 0.016,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: height * 0.0035),
                Text(
                  user.name,
                  style: TextStyle(   overflow: TextOverflow.ellipsis,
                    fontSize: height * 0.012,
                    color: MyColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),

          isMySelf
              ? SizedBox.shrink()
              : isFollowedByMe
              ? MiniElevatedOutlinedCTA(
                onPressed: () {
                  FollowStatusManager.isAlreadyFollwing[user.username] = false;
                  BlocProvider.of<UnfollowUserBloc>(
                    context,
                  ).add(UnfollowRequested(username: user.username));
                  setState(() {});
                },
                buttonName: "Unfollow",
              )
              : MiniElevatedCTA(
                onPressed: () {
                  FollowStatusManager.isAlreadyFollwing[user.username] = true;
                  BlocProvider.of<FollowUserBloc>(
                    context,
                  ).add(FollowRequested(username: user.username));
                  setState(() {});
                },
                buttonName: "Follow",
              ),
        ],
      ),
    );
  }
}
