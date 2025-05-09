import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/post_widget.dart';
import 'package:snibbo_app/core/widgets/user_story_widget.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/get_feed_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/get_feed_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/get_feed_states.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/feed_app_bar.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/my_story_widget.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/test_list.dart';

@RoutePage()
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final testList = TestList.test();
  bool showedInitialData = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!showedInitialData) {
        context.read<GetFeedBloc>().add(GetFeedData());
        showedInitialData = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 1000) {
          UiUtils.showBottomSheet(
            context: context,
            isDark: isDark,
            h1: "Create Your Story",
            h2:
                "Capture a photo or pick one from your gallery to begin sharing your special moments.",
                cameraSourceTap: () {},
                gallerySourceTap: () {}
          );
        } else if (details.primaryVelocity! < -1000) {
          debugPrint("Redirect to chats");
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<GetFeedBloc, GetFeedStates>(
            listener: (context, state) {
              //** LISTENER */

              // ERROR STATE HANDLING ---->
              if (state is GetFeedErrorState) {
                UiUtils.showToast(
                  title: state.title,
                  isDark: isDark,
                  description: state.description,
                  context: context,
                  isSuccess: false,
                  isWarning: false,
                );
              }
            },
            builder: (context, state) {
              //** BUILDER */
              return CustomScrollView(
                slivers: [
                  FeedAppBar(),
                  // SUCCESS STATE HANDLING --->
                  if (state is GetFeedSuccessState) ...[
                    // - STORIES BUILDER
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: height * 0.14,
                        child: Row(
                          children: [
                            // - MY STORY
                            MyStoryWidget(
                              showBorder:
                                  state.myStories.userStories.isEmpty
                                      ? false
                                      : true,
                              profileUrl: state.myStories.profilePicture,
                              username: state.myStories.username,
                              isDark: isDark,
                            ),

                            // - USER STORIES
                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.storiesList.length,
                              itemBuilder: (context, index) {
                                debugPrint("Story builds $index");
                                final story = state.storiesList[index];
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    UserStoryWidget(
                                      showBorder: true,
                                      greyBorder: false,
                                      profileUrl: testList[index],
                                      showComment: false,
                                      showLike: false,
                                      isMini: false,
                                      margins: EdgeInsets.fromLTRB(
                                        width * 0.023,
                                        height * 0.015,
                                        width * 0.023,
                                        height * 0.004,
                                      ),
                                      storySize: 0.10,
                                    ),
                                    Text(
                                      story.username,
                                      style: TextStyle(
                                        fontSize: height * 0.013,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // - FEED POSTS BUILDER
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.postsList.length,
                        (context, index) {
                          final post = state.postsList[index];
                          return PostWidget(postContentUrl: post.postContent);
                        },
                      ),
                    ),
                  ]
                  // ERROR STATE HANDLING --->
                  else if (state is GetFeedErrorState) ...[
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height:
                            height - kBottomNavigationBarHeight - height * 0.16,
                        width: width,
                        child: Center(child: Text("No Posts Found")),
                      ),
                    ),
                  ]
                  //NULL STATE HANDLING --->
                  else ...[
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height:
                            height - kBottomNavigationBarHeight - height * 0.16,
                        width: width,
                        child: Center(child: CircularProgressLoading()),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
