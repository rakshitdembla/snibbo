import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
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
  final String? username;
  final bool? hasActiveStories;
  final bool? isAllStoriesViewed;
  final bool isStatic;
  final List<UserEntity>? storyUsers;

  const UserCircularProfileWidget({
    super.key,
    required this.profileUrl,
    required this.margins,
    required this.storySize,
    this.username,
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
  bool blocUpdated = false;
  late bool allViewedState;

  @override
  void initState() {
    allViewedState = widget.isAllStoriesViewed ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final height = UiUtils.screenHeight(context);
    final storyRadius = height * widget.storySize;

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
        debugPrint(
          "Rebuilt the user circular profile widget for ${widget.username}",
        );
        if (state is AllStoriesSeenState) {
          if (state.username == widget.username && !widget.isStatic) {
            if (!blocUpdated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  allViewedState = true;
                  blocUpdated = true;
                });
              });
            }
          }
        }

        return Container(
          padding: EdgeInsets.all(storyRadius * 0.04),
          margin: widget.margins,
          height: storyRadius,
          width: storyRadius,
          decoration: BoxDecoration(
            gradient:
                widget.hasActiveStories == true &&
                        allViewedState != true &&
                        widget.isStatic != true
                    ? MyColors.gradient
                    : null,
            color: allViewedState ? MyColors.lowOpacitySecondary : null,
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

    return widget.username != null && !widget.isStatic
        ? GestureDetector(
          onTap: () {
            debugPrint("tapped on ${widget.username}");
            {
              context.router.push(
                FetchStoriesLoadingRoute(
                  storyUsers: widget.storyUsers,
                  username: widget.username!,
                  isPreviousSlide: false,
                  profilePicture: widget.profileUrl,
                ),
              );
            }
          },
          child: storyWidget,
        )
        : storyWidget;
  }
}
