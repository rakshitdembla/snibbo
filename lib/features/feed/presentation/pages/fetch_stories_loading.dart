import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/delete_story_bloc/get_user_stories_bloc/get_user_stories_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/delete_story_bloc/get_user_stories_bloc/get_user_stories_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/delete_story_bloc/get_user_stories_bloc/get_user_stories_states.dart';
import 'package:snibbo_app/features/feed/presentation/pages/story_view_screen.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/stories/story_user_details_widget.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

@RoutePage()
class FetchStoriesLoading extends StatefulWidget {
  final String username;
  final bool isPreviousSlide;
  final List<UserEntity>? storyUsers;
  final String profilePicture;
  const FetchStoriesLoading({
    super.key,
    required this.username,
    required this.isPreviousSlide,
    required this.profilePicture,
    this.storyUsers,
  });

  @override
  State<FetchStoriesLoading> createState() => _FetchStoriesLoadingState();
}

class _FetchStoriesLoadingState extends State<FetchStoriesLoading> {
  bool showLoading = true;
  late UserStoriesEntity user;
  late bool isMyStory;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetUserStoriesBloc>(
      context,
    ).add(GetUserStories(username: widget.username));
  }

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return BlocListener<GetUserStoriesBloc, UserStoriesStates>(
      listenWhen: (previous, current) {
        if (current is UserStoriesSuccessState) {
          return current.username == widget.username;
        } else if (current is UserStoriesErrorState) {
          return current.username == widget.username;
        }
        return false;
      },
      listener: (context, state) async {
        if (state is UserStoriesSuccessState &&
            state.userStories.userStories.isNotEmpty) {
          final username = await ServicesUtils.getUsername();

          isMyStory = state.userStories.username == username;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              showLoading = false;
              user = state.userStories;
            });
          });
        } else if (state is UserStoriesSuccessState &&
            state.userStories.userStories.isEmpty) {
          UiUtils.showToast(
            title: "No story found.",
            isDark: isDark,
            description: "User stories are expired or not found.",
            context: context,
            isSuccess: false,
            isWarning: false,
          );

          if (context.mounted) {
            context.router.popUntilRoot();
          }
        } else if (state is UserStoriesErrorState) {
          UiUtils.showToast(
            title: state.title,
            isDark: isDark,
            description: state.description,
            context: context,
            isSuccess: false,
            isWarning: false,
          );

          if (context.mounted) {
            context.router.popUntilRoot();
          }
        }
      },
      child:
          showLoading
              ? Scaffold(
                body: Stack(
                  children: [
                    Container(
                      color: MyColors.black,
                      height: height,
                      width: width,
                    ),
                    Positioned(
                      left: width * 0.03,
                      top: height * 0.11,
                      child: StoryUserDetailsWidget(
                        profilePicture: widget.profilePicture,
                        username: widget.username,
                      ),
                    ),

                    Center(child: CircularProgressLoading()),
                  ],
                ),
              )
              : StoryViewScreen(
                isMyStory: isMyStory,
                stories: user.userStories,
                username: user.username,
                profilePicture: user.profilePicture,
                storyUsers: widget.storyUsers,
              ),
    );
  }
}