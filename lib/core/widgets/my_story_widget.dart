import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_story_bloc/create_story_bloc.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_story_bloc/create_story_states.dart';
import 'package:snibbo_app/features/create/presentation/pages/create_story_sheet.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class MyStoryWidget extends StatelessWidget {
  final bool hasActiveStories;
  final String profileUrl;
  final String username;
  final bool isDark;
  final UserStoriesEntity myStoryState;
  const MyStoryWidget({
    super.key,
    required this.myStoryState,
    required this.username,
    required this.profileUrl,
    required this.hasActiveStories,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return Padding(
      padding: EdgeInsets.only(left: width * 0.015),
      child: GestureDetector(
        onTap: () {
              FocusScope.of(context).unfocus();
          myStoryState.userStories.isNotEmpty ?
          context.router.push(
            StoryViewScreenRoute(
              isMyStory: true,
              stories: myStoryState.userStories,
              username: username,
              profilePicture: profileUrl,
            ),
          ) : null;
        },
        child: Column(
          children: [
            Stack(
              children: [
                UserCircularProfileWidget(
                  isAllStoriesViewed: hasActiveStories,
                  hasActiveStories: hasActiveStories,
                  username: username,
                  isStatic: false,
                  profileUrl: profileUrl,
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
                      //** --> Create Story Loading Builder
                      child: BlocBuilder<CreateStoryBloc, CreateStoryStates>(
                        builder: (context, state) {
                          return state is CreateStoryLoadingState
                              ? SizedBox(
                                height: height * 0.01,
                                width: height * 0.01,
                                child: CircularProgressIndicator(
                                  strokeWidth: height * 0.002,
                                  color:
                                      isDark ? MyColors.black : MyColors.white,
                                ),
                              )
                              : GestureDetector(
                                onTap: () {
                                      FocusScope.of(context).unfocus();
                                  CreateStorySheet.show(
                                    context: context,
                                    isDark: isDark,
                                  );
                                },
                                child: Icon(
                                  Icons.add,
                                  size: height * 0.02,
                                  color:
                                      isDark
                                          ? MyColors.darkPrimary
                                          : MyColors.primary,
                                ),
                              );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              username,
              style: TextStyle(   overflow: TextOverflow.ellipsis,
                fontSize: height * 0.013,
                color: isDark ? MyColors.darkRefresh : const Color.fromARGB(255, 85, 85, 85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
