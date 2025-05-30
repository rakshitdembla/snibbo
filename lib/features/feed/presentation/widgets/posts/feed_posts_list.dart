import 'package:flutter/widgets.dart';
import 'package:snibbo_app/core/widgets/post_widget.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/get_feed_states.dart';

class FeedPostsList extends StatelessWidget {
  final GetFeedSuccessState state;
  const FeedPostsList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: state.postsList.length, (
        context,
        index,
      ) {
        final post = state.postsList[index];
        return PostWidget(postContentUrl: post.postContent);
      }),
    );
  }
}
