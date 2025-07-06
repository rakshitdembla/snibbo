import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/error_screen.dart';
import 'package:snibbo_app/core/widgets/refresh_bar.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_story_bloc/create_story_bloc.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_story_bloc/create_story_states.dart';
import 'package:snibbo_app/features/create/presentation/pages/create_story_sheet.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/get_feed_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/get_feed_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/get_feed_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_pagination_bloc/post_pagination_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_pagination_bloc/post_pagination_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/story_pagination_bloc/story_pagination_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/story_pagination_bloc/story_pagination_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/story_pagination_bloc/story_pagination_states.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/feed_app_bar.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/posts/feed_posts_list.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/stories/feed_stories_list.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class FeedScreen extends StatefulWidget {
  final PersistentTabController navController;
  const FeedScreen({super.key, required this.navController});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController controller = ScrollController();
  late StoryPaginationBloc paginationBloc;

  @override
  void initState() {
    paginationBloc = context.read<StoryPaginationBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetFeedBloc>().add(GetFeedData());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;

    //@ --> Left-Right Swipe Gestures
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 1000) {
          CreateStorySheet.show(context: context, isDark: isDark);
        } else if (details.primaryVelocity! < -1000) {
          debugPrint("Redirect to chats");
        }
      },

      //@ --> Bloc Listeners
      child: MultiBlocListener(
        listeners: [
          //# Create Story Listener ->
          BlocListener<CreateStoryBloc, CreateStoryStates>(
            listener: (context, storyState) {
              if (storyState is CreateStoryErrorState) {
                UiUtils.showToast(
                  title: storyState.title,
                  isDark: isDark,
                  description: storyState.description,
                  context: context,
                  isSuccess: false,
                  isWarning: false,
                );
              } else if (storyState is CreateStorySucessState) {
                context.read<GetFeedBloc>().add(GetFeedData());
                UiUtils.showToast(
                  title: storyState.title,
                  isDark: isDark,
                  description: storyState.description,
                  context: context,
                  isSuccess: true,
                  isWarning: false,
                );
              }
            },
          ),

          //# Get Feed Listener ->
          BlocListener<GetFeedBloc, GetFeedStates>(
            listener: (context, feedState) {
              if (feedState is GetFeedErrorState) {
                UiUtils.showToast(
                  title: feedState.title,
                  isDark: isDark,
                  description: feedState.description,
                  context: context,
                  isSuccess: false,
                  isWarning: false,
                );
              } else if (feedState is GetFeedSuccessState) {
                context.read<StoryPaginationBloc>().add(
                  InitializePaginationStories(
                    initialStories: feedState.storiesList ?? [],
                  ),
                );
                context.read<PostPaginationBloc>().add(
                  InitializePaginationPosts(initialPosts: feedState.postsList),
                );
              }
            },
          ),
        ],

        //** --> Scaffold Body
        child: Scaffold(
          body:
          //@ --> Get Feed BLoc Builder
          SafeArea(
            child: BlocBuilder<GetFeedBloc, GetFeedStates>(
              builder: (context, state) {
                return MyRefreshBar(
                  onRefresh: () async {
                    await Future.delayed(500.ms);
                    if (context.mounted) {
                      context.read<GetFeedBloc>().add(GetFeedData());
                    }
                  },
                  widget: CustomScrollView(
                    controller: controller,
                    physics: AlwaysScrollableScrollPhysics(),
                    slivers: [
                      FeedAppBar(navController: widget.navController),
                      //# Success State Handling ->
                      if (state is GetFeedSuccessState) ...[
                        SliverToBoxAdapter(
                          //$ Story Pagination BLoc Consumer
                          child: BlocConsumer<
                            StoryPaginationBloc,
                            StoryPaginationStates
                          >(
                            //Story Pagination Listener
                            listener: (context, paginationState) {
                              if (paginationState is StoryPaginationError) {
                                UiUtils.showToast(
                                  title: paginationState.title,
                                  isDark: isDark,
                                  description: paginationState.description,
                                  context: context,
                                  isSuccess: false,
                                  isWarning: false,
                                );
                              }
                            },
                            //Story Pagination Builder
                            builder: (context, paginationState) {
                              final allStories = paginationBloc.allStories;
                              //Feed Stories
                              return FeedStoriesList(
                                allStories: allStories,
                                state: state,
                              );
                            },
                          ),
                        ),
                        //# Feed Posts ->
                        FeedPostsList(controller: controller),
                      ]
                      //#Error State Handling ->
                      else if (state is GetFeedErrorState) ...[
                        SliverToBoxAdapter(
                          child: MyRefreshBar(
                            onRefresh: () async {
                              await Future.delayed(500.ms);
                              if (context.mounted) {
                                context.read<GetFeedBloc>().add(GetFeedData());
                              }
                            },
                            widget: ErrorScreen(isFeedError: true),
                          ),
                        ),
                      ]
                      //#Null State Handling ->
                      else ...[
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height:
                                height -
                                kBottomNavigationBarHeight -
                                height * 0.16,
                            width: width,
                            child: Center(child: CircularProgressLoading()),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
