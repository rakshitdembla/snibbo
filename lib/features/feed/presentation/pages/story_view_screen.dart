import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/user_story_widget.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/delete_story_bloc/delete_story_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/delete_story_bloc/delete_story_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/delete_story_bloc/delete_story_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/story_viewers_bloc/story_viewers_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/story_viewers_bloc/story_viewers_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/view_story_bloc/view_story_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/view_story_bloc/view_story_events.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/icon_with_text.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/story_view_widget.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/story_viewers_sheet.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import "package:story_view/story_view.dart";

@RoutePage()
class StoryViewScreen extends StatefulWidget {
  final List<StoryEntitiy> stories;
  final String username;
  final String profilePicture;
  final bool isMyStory;
  const StoryViewScreen({
    super.key,
    required this.stories,
    required this.username,
    required this.profilePicture,
    required this.isMyStory,
  });

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  StoryController controller = StoryController();
  late List<StoryItem> storyItems;
  int storyIndex = 0;
  late String storyId;

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

    //--> Delete Story States
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
          });
        }
      },
      child: Scaffold(
        backgroundColor: MyColors.black,
        body:
        // --> StoryView Widget
        Stack(
          children: [
            StoryViewWidget(
              storyItems: storyItems,
              controller: controller,
              onStoryShow: (storyItem, index) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    storyIndex = index;
                    storyId = widget.stories[index].id;
                  });
                });
                BlocProvider.of<ViewStoryBloc>(context).add(ViewStory(storyId: storyId));
              },
            ),

            // --> UserDetails
            Positioned(
              left: width * 0.03,
              top: height * 0.11,
              child: Row(
                children: [
                  UserStoryWidget(
                    showBorder: false,
                    greyBorder: false,
                    profileUrl: widget.profilePicture,
                    storySize: 0.045,
                    isMini: true,
                    margins: EdgeInsets.zero,
                  ),
                  SizedBox(width: width * 0.015),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.username,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: MyColors.white,
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        ServicesUtils.toTimeAgo(
                          widget.stories[storyIndex].createdAt,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 172, 171, 171),
                          fontSize: width * 0.025,
                        ),
                      ),
                    ],
                  ),
                ],
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
                          IconWithText(
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
                              ? CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  MyColors.white,
                                ),
                                strokeWidth: 6.0,
                              )
                              : IconWithText(
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
