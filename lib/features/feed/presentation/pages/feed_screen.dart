import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/post_widget.dart';
import 'package:snibbo_app/core/widgets/user_profile_pic_widget.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_story_bloc/create_story_bloc.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_story_bloc/create_story_states.dart';
import 'package:snibbo_app/features/create/presentation/pages/create_story_sheet.dart';
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

  @override
  void initState() {
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
              }
            },
          ),
        ],

        //** --> Scaffold Body
        child: Scaffold(
          body: SafeArea(
            //@ --> Get Feed BLoc Builder
            child: BlocBuilder<GetFeedBloc, GetFeedStates>(
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    FeedAppBar(),
                    //# Success State Handling ->
                    if (state is GetFeedSuccessState) ...[
                      //# Stories Builder ->
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: height * 0.14,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.storiesList!.length + 1,
                            itemBuilder: (context, index) {
                              //# My Story ->
                              if (index == 0) {
                                return MyStoryWidget(
                                  myStoryState: state.myStories,
                                  showBorder:
                                      state.myStories.userStories.isEmpty
                                          ? false
                                          : true,
                                  profileUrl: state.myStories.profilePicture,
                                  username: state.myStories.username,
                                  isDark: isDark,
                                );
                              } else {
                                final story = state.storiesList![index - 1];
                                //# User Stories ->

                                //   BlocProvider.of<GetUserStoriesBloc>(
                                //   context,
                                // ).add(GetUserStories(username: username!))
                                //! add this
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    UserProfilePicWidget(
                                      showBorder: true,
                                      greyBorder: false,
                                      profileUrl: testList[index],
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
                              }
                            },
                          ),
                        ),
                      ),
                      //# Feed Posts ->
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
                    //#Error State Hnadling ->
                    else if (state is GetFeedErrorState) ...[
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height:
                              height -
                              kBottomNavigationBarHeight -
                              height * 0.16,
                          width: width,
                          child: Center(child: Text("No Posts Found")),
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
