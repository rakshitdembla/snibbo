import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/my_story_widget.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/get_feed_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/story_pagination_bloc/story_pagination_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/story_pagination_bloc/story_pagination_events.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class FeedStoriesList extends StatefulWidget {
  final List<UserEntity> allStories;
  final GetFeedSuccessState state;
  const FeedStoriesList({
    super.key,
    required this.allStories,
    required this.state,
  });

  @override
  State<FeedStoriesList> createState() => _FeedStoriesListState();
}

class _FeedStoriesListState extends State<FeedStoriesList> {
  late StoryPaginationBloc paginationBloc;
  final ScrollController controller = ScrollController();

  void _controllerListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (paginationBloc.hasMore && !paginationBloc.isLoading) {
        context.read<StoryPaginationBloc>().add(LoadMoreUserStories());
      }
    }
  }

  @override
  void initState() {
    paginationBloc = context.read<StoryPaginationBloc>();
    controller.addListener(_controllerListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return SizedBox(
      height: height * 0.14,
      child: ListView.builder(
        controller: controller,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount:
            widget.allStories.length + 2, // +1 for "My Story", +1 for loader
        itemBuilder: (context, index) {
          //# My Story ->
          if (index == 0) {
            return MyStoryWidget(
              myStoryState: widget.state.myStories,
              showBorder:
                  widget.state.myStories.userStories.isEmpty ? false : true,
              profileUrl: widget.state.myStories.profilePicture,
              username: widget.state.myStories.username,
              isDark: isDark,
            );
          }
          //# If has More Stories->
          else if (index == widget.allStories.length + 1) {
            return paginationBloc.hasMore
                ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Center(child: CircularProgressLoading()),
                )
                : SizedBox.shrink();
          } else {
            //# User Stories ->
            final story = widget.allStories[index - 1];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserCircularProfileWidget(
                  showBorder: true,
                  username: story.username,
                  greyBorder:
                      story.storiesSeen != null && story.storiesSeen == true
                          ? true
                          : false,
                  profileUrl: story.profilePicture.toString(),

                  margins: EdgeInsets.fromLTRB(
                    width * 0.023,
                    height * 0.015,
                    width * 0.023,
                    height * 0.004,
                  ),
                  storySize: 0.10,
                  storyUsers: widget.state.storiesList,
                ),
                Text(
                  story.username,
                  style: TextStyle(fontSize: height * 0.013),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
