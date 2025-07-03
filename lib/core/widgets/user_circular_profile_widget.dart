import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/local_data_manager/story_views_manager.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/view_story_bloc/view_story_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/view_story_bloc/view_story_states.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class UserCircularProfileWidget extends StatefulWidget {
  final EdgeInsetsGeometry margins;
  final dynamic profileUrl;
  final bool? isFile;
  final double storySize;
  final String username;
  final bool? stopRoute;
  final bool? hasActiveStories;
  final bool? isAllStoriesViewed;
  final bool isStatic;
  final List<UserEntity>? storyUsers;

  const UserCircularProfileWidget({
    super.key,
    required this.profileUrl,
    required this.margins,
    required this.storySize,
    this.stopRoute,
    required this.username,
    required this.hasActiveStories,
    required this.isAllStoriesViewed,
    required this.isStatic,
    this.storyUsers,
    this.isFile,
  });

  @override
  State<UserCircularProfileWidget> createState() => _UserStoryWidgetState();
}

class _UserStoryWidgetState extends State<UserCircularProfileWidget> {
  late bool isAllViewed;

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final height = UiUtils.screenHeight(context);
    final storyRadius = height * widget.storySize;

    isAllViewed =
        StoryViewsManager.storyViewStatus[widget.username] ??
        widget.isAllStoriesViewed ??
        widget.hasActiveStories ??
        false;

    //Base story widget -->

    final storyWidget = BlocBuilder<ViewStoryBloc, ViewStoryStates>(
      buildWhen: (previous, current) {
        if (current is AllStoriesSeenState &&
            current.username == widget.username) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is AllStoriesSeenState) {
          isAllViewed = state.status[widget.username] ?? isAllViewed;
        }

        return Container(
          padding: EdgeInsets.all(storyRadius * 0.04),
          margin: widget.margins,
          height: storyRadius,
          width: storyRadius,
          decoration: BoxDecoration(
            gradient:
                widget.hasActiveStories == true &&
                        isAllViewed != true &&
                        widget.isStatic != true
                    ? MyColors.gradient
                    : null,
            color:
                isAllViewed &&
                        !widget.isStatic &&
                        widget.hasActiveStories != false
                    ? MyColors.lowOpacitySecondary
                    : null,
            shape: BoxShape.circle,
          ),
          child: Container(
            padding:
                widget.hasActiveStories == true
                    ? EdgeInsets.all(storyRadius * 0.03)
                    : EdgeInsets.zero,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? MyColors.darkPrimary : MyColors.primary,
            ),
            child: ClipOval(
              child:
                  widget.isFile != null && widget.isFile!
                      ? Image.file(
                        widget.profileUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            MyAssets.profilePictureHolder,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                      : Image.network(
                        widget.profileUrl,
                        fit: BoxFit.cover,
                        frameBuilder: (
                          context,
                          child,
                          frame,
                          wasSynchronouslyLoaded,
                        ) {
                          return UiUtils.showShimmerBuilder(
                            wasSynchronouslyLoaded: wasSynchronouslyLoaded,
                            frame: frame,
                            child: child,
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            MyAssets.profilePictureHolder,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
            ),
          ),
        );
      },
    );

    return !widget.isStatic && widget.stopRoute != true
        ? GestureDetector(
          onTap: () {
            if (widget.hasActiveStories == true) {
              context.router.push(
                FetchStoriesLoadingRoute(
                  storyUsers: widget.storyUsers,
                  username: widget.username,
                  isPreviousSlide: false,
                  profilePicture: widget.profileUrl,
                ),
              );
            } else {
              context.router.push(
                UserProfileScreenRoute(username: widget.username),
              );
            }
          },
          child: storyWidget,
        )
        : storyWidget;
  }
}
