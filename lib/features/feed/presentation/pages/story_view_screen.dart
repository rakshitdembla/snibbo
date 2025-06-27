import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/delete_story_bloc/delete_story_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/delete_story_bloc/delete_story_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/delete_story_bloc/delete_story_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/get_feed_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/get_feed_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/story_viewers_bloc/story_viewers_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/story_viewers_bloc/story_viewers_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/view_story_bloc/view_story_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/view_story_bloc/view_story_events.dart';
import 'package:snibbo_app/features/feed/presentation/helpers/storyhelpers.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/stories/story_user_details_widget.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/stories/story_view_widget.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/stories/story_viewers_sheet.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import "package:story_view/story_view.dart";

@RoutePage()
class StoryViewScreen extends StatefulWidget {
  final List<StoryEntitiy> stories;
  final List<UserEntity>? storyUsers;
  final String username;
  final String profilePicture;
  final bool isMyStory;
  const StoryViewScreen({
    super.key,
    required this.stories,
    required this.username,
    required this.profilePicture,
    required this.isMyStory,
    this.storyUsers,
  });

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  StoryController controller = StoryController();
  late List<StoryItem> storyItems;
  int storyIndex = 0;
  late String storyId;
  List<UserEntity>? storyUsers;

  @override
  void initState() {
    storyItems =
        widget.stories
            .map(
              (story) => StoryItem.pageImage(
                loadingWidget: CircularProgressLoading(),
                // errorWidget: ,
                duration: Duration(seconds: 15),
                url: story.storyContent,
                controller: controller,
              ),
            )
            .toList();
    storyId = widget.stories[0].id;
    storyUsers = widget.storyUsers;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final deleteLoadingState =
        context.watch<DeleteStoryBloc>().state is DeleteStoryLoadingState;

    //--> Delete Story Listener
    return BlocListener<DeleteStoryBloc, DeleteStoryStates>(
      listener: (context, state) {
        if (state is DeleteStoryErrorState) {
          UiUtils.showToast(
            title: state.title,
            isDark: isDark,
            description: state.description,
            context: context,
            isSuccess: false,
            isWarning: false,
          );
        } else if (state is DeleteStorySuccessState) {
          UiUtils.showToast(
            title: state.title,
            isDark: isDark,
            description: state.description,
            context: context,
            isSuccess: true,
            isWarning: false,
          );
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) Navigator.of(context).pop();
            context.read<GetFeedBloc>().add(GetFeedData());
          });
        }
      },
      child: Scaffold(
        backgroundColor: MyColors.black,
        body:
        // --> StoryView Widget
        Stack(
          children: [
            //Swipes
            GestureDetector(
              onHorizontalDragEnd: (details) {
                if (storyUsers != null && storyUsers!.isNotEmpty) {
                  if (details.primaryVelocity! < 0) {
                    StoryHelpers().goToNextStory(
                      widget.username,
                      storyUsers!,
                      context,
                    );
                  } else if (details.primaryVelocity! > 0) {
                    StoryHelpers().goToPreviousStory(
                      widget.username,
                      storyUsers!,
                      context,
                    );
                  }
                }
              },

              child: StoryViewWidget(
                storyItems: storyItems,
                controller: controller,
                //-- on story show
                onStoryShow: (storyItem, index) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      storyIndex = index;
                      storyId = widget.stories[storyIndex].id;
                    });
                    if (!widget.isMyStory) {
                      BlocProvider.of<ViewStoryBloc>(
                        context,
                      ).add(ViewStory(storyId: storyId));
                    }
                  });

                  if (index == widget.stories.length - 1) {
                    if (!widget.isMyStory) {
                      debugPrint("Adding all stories seen event for ${widget.username}");
                      BlocProvider.of<ViewStoryBloc>(
                        context,
                      ).add(AllStoriesSeen(username: widget.username));
                    }
                  }
                },

                //On story complete
                onComplete: () {
                  if (storyUsers != null && storyUsers!.isNotEmpty) {
                    debugPrint("Going on next story!");
                    debugPrint("$storyUsers");
                    StoryHelpers().goToNextStory(
                      widget.username,
                      storyUsers!,
                      context,
                    );
                  } else {
                    context.router.pop();
                  }
                },

                //On Vertical Swipes
                onVerticalSwipeComplete: (direction) {
                  if (direction == Direction.down) {
                    context.router.pop();
                  } else if (direction == Direction.up && widget.isMyStory) {
                    BlocProvider.of<StoryViewersBloc>(
                      context,
                    ).add(GetStoryViewers(storyId: storyId));
                    StoryViewersSheet.show(
                      context: context,
                      isDark: isDark,
                      controller: controller,
                    );
                  }
                },
              ),
            ),

            // --> UserDetails
            Positioned(
              left: width * 0.03,
              top: height * 0.11,
              child: StoryUserDetailsWidget(
                profilePicture: widget.profilePicture,
                stories: widget.stories,
                storyIndex: storyIndex,
                username: widget.username,
              ),
            ),

            // --> Story Actions
            widget.isMyStory
                ? Positioned(
                  bottom: height * 0.01,
                  child: SizedBox(
                    width: width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Row(
                        children: [
                          IconWithText._(
                            height: height,
                            icon: Icons.group_outlined,
                            text: "Activity",
                            onTap: () {
                              controller.pause();
                              BlocProvider.of<StoryViewersBloc>(
                                context,
                              ).add(GetStoryViewers(storyId: storyId));
                              StoryViewersSheet.show(
                                controller: controller,
                                context: context,
                                isDark: isDark,
                              );
                            },
                          ),
                          Spacer(),
                          deleteLoadingState
                              ? SecondaryCircularProgress()
                              : IconWithText._(
                                height: height,
                                icon: Icons.delete_outline,
                                text: "Delete",
                                onTap: () {
                                  BlocProvider.of<DeleteStoryBloc>(
                                    context,
                                  ).add(DeleteStory(storyId: storyId));
                                },
                              ),
                        ],
                      ),
                    ),
                  ),
                )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  final double height;
  final IconData icon;
  final String text;
  final GestureTapCallback? onTap;
  const IconWithText._({
    required this.height,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: MyColors.white, size: height * 0.0275),
          SizedBox(height: height * (0.002)),
          Text(
            text,
            style: TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.w500,
              fontSize: height * 0.014,
            ),
          ),
        ],
      ),
    );
  }
}
