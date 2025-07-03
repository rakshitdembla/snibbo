import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_widget.dart';
import 'package:snibbo_app/features/explore/presentation/bloc/explore_posts_bloc/explore_posts_bloc.dart';
import 'package:snibbo_app/features/explore/presentation/bloc/explore_posts_bloc/explore_posts_events.dart';
import 'package:snibbo_app/features/explore/presentation/bloc/explore_posts_bloc/explore_posts_states.dart';

@RoutePage()
class ExplorePostsViewScreen extends StatefulWidget {
  final int initialIndex;
  const ExplorePostsViewScreen({super.key, required this.initialIndex});

  @override
  State<ExplorePostsViewScreen> createState() => _ExplorePostsViewScreenState();
}

class _ExplorePostsViewScreenState extends State<ExplorePostsViewScreen> {
  late ExplorePostsBloc explorePostsBloc;
  late AutoScrollController autoScrollController;

  void _listener() {
    if (autoScrollController.position.pixels ==
        autoScrollController.position.maxScrollExtent) {
      if (explorePostsBloc.hasMore && !explorePostsBloc.isLoading) {
        explorePostsBloc.add(LoadMoreExplorePosts());
      }
    }
  }

  void scrollToIndex() async {
    await autoScrollController.scrollToIndex(
      widget.initialIndex,
      preferPosition: AutoScrollPosition.begin,
      duration: Duration(milliseconds: 300)
    );
  }

  @override
  void initState() {
    explorePostsBloc = context.read<ExplorePostsBloc>();
    autoScrollController = AutoScrollController(axis: Axis.vertical);
    autoScrollController.addListener(_listener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToIndex();
    });
    super.initState();
  }

  @override
  void dispose() {
    autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true, title: Text("Explore")),
      body: SafeArea(
        child: BlocBuilder<ExplorePostsBloc, ExplorePostsStates>(
          builder: (context, state) {
            return ListView.builder(
                controller: autoScrollController,
                itemCount: explorePostsBloc.allPosts.length + 1,
                itemBuilder: (context, index) {
                  if (index == explorePostsBloc.allPosts.length) {
                    return explorePostsBloc.hasMore
                        ? Center(child: CircularProgressLoading())
                        : SizedBox.shrink();
                  }
                  final post = explorePostsBloc.allPosts[index];
                  return AutoScrollTag(
                    key: ValueKey(index),
                    controller: autoScrollController,
                    index: index,
                    child: PostWidget(key: ValueKey(post.id),postEntity: post),
                  );
                },
              );
         
          },
        ),
      ),
    );
  }
}
