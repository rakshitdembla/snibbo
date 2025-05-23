import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_user_stories_bloc/get_user_stories_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_user_stories_bloc/get_user_stories_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_user_stories_bloc/get_user_stories_states.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class UserProfilePicWidget extends StatefulWidget {
  final EdgeInsetsGeometry margins;
  final String profileUrl;
  final double storySize;
  final bool isMini;
  final String? username;
  final bool showBorder;
  final bool greyBorder;

  const UserProfilePicWidget({
    super.key,
    required this.profileUrl,
    required this.margins,
    required this.storySize,
    this.username,
    required this.isMini,
    required this.greyBorder,
    required this.showBorder,
  });

  @override
  State<UserProfilePicWidget> createState() => _UserProfilePicWidgetState();
}

class _UserProfilePicWidgetState extends State<UserProfilePicWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final height = UiUtils.screenHeight(context);
    final storyRadius = height * widget.storySize;
    return BlocConsumer<GetUserStoriesBloc, UserStoriesStates>(
      listener: (context, state) {
        if (state is UserStoriesErrorState) {
          UiUtils.showToast(
            title: state.title,
            isDark: isDark,
            description: state.description,
            context: context,
            isSuccess: false,
            isWarning: false,
          );
        } else if (state is UserStoriesSuccessState &&
            state.userStories.userStories.isNotEmpty) {
          debugPrint("SUCCESS STATE && STORIES NOT EMPTY SO ROUTING......");
          final user = state.userStories;
          context.router.push(
            StoryViewScreenRoute(
              stories: user.userStories,
              username: user.username,
              profilePicture: user.profilePicture,
            ),
          );
        } else {}
      },
      builder: (context, state) {
        final storyWidget = GestureDetector(
          onTap: () {
            debugPrint("ADDED GET USERSTORIES BY USERNAME EVENT");
            widget.username != null
                ? context.read<GetUserStoriesBloc>().add(
                  GetUserStories(username: widget.username!),
                )
                : null;
          },
          child: Container(
            padding: EdgeInsets.all(
              widget.isMini ? storyRadius * 0.050 : storyRadius * 0.04,
            ),
            margin: widget.margins,
            height: storyRadius,
            width: storyRadius,
            decoration: BoxDecoration(
              gradient:
                  widget.showBorder
                      ? widget.greyBorder
                          ? null
                          : MyColors.gradient
                      : null,
              color:
                  widget.showBorder
                      ? widget.greyBorder
                          ? MyColors.lowOpacitySecondary
                          : null
                      : null,
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: EdgeInsets.all(
                widget.isMini ? storyRadius * 0.06 : storyRadius * 0.03,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? MyColors.darkPrimary : MyColors.primary,
              ),
              child: ClipOval(
                child: Image.network(
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
          ),
        );

        return state is UserStoriesLoadingState
            ? storyWidget
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: Duration(milliseconds: 1000))
            : storyWidget;
      },
    );
  }
}
