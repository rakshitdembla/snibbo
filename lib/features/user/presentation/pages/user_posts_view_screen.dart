import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_widget.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_states.dart';
import 'package:snibbo_app/features/user/presentation/helpers/user_posts_helper.dart';

@RoutePage()
class UserPostsViewScreen extends StatefulWidget {
  final ProfileEntity profileEntity;
  final int initialIndex;
  const UserPostsViewScreen({
    super.key,
    required this.profileEntity,
    required this.initialIndex,
  });

  @override
  State<UserPostsViewScreen> createState() => _UserPostsViewScreenState();
}

class _UserPostsViewScreenState extends State<UserPostsViewScreen> {
  late UserPostsPaginationBloc userPostsBloc;
  late AutoScrollController autoScrollController;

  void _listener() {
    if (autoScrollController.position.pixels ==
        autoScrollController.position.maxScrollExtent) {
      final hasMoreUserPosts =
          UserPostsHelper.hasMore[widget.profileEntity.username] == true;

      final userPostsLoading =
          UserPostsHelper.isLoading[widget.profileEntity.username] == true;

      debugPrint("$hasMoreUserPosts $userPostsLoading");

      if (hasMoreUserPosts && !userPostsLoading) {
        userPostsBloc.add(
          LoadMoreUserPosts(username: widget.profileEntity.username),
        );
      }
    }
  }

  void scrollToIndex() async {
    await autoScrollController.scrollToIndex(
      widget.initialIndex,
      preferPosition: AutoScrollPosition.begin,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void initState() {
    userPostsBloc = context.read<UserPostsPaginationBloc>();
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
      appBar: AppBar(
        title: Text("User Posts"),
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<UserPostsPaginationBloc, UserPostsPaginationStates>(
        buildWhen: (previous, current) {
          if (current is UserPostsPaginationLoaded) {
            return current.username == widget.profileEntity.username;
          } else if (current is RefreshUserPostsPagination) {
            return current.username == widget.profileEntity.username;
          }
          return false;
        },
        builder: (context, state) {
          if (state is RefreshUserPostsPagination ) {
            return Center(child: CircularProgressLoading(),);
          }
          
          final allPosts = UserPostsHelper.posts[widget.profileEntity.username];

          if (allPosts == null) {
            return SizedBox.shrink();
          }
          return ListView.builder(
            controller: autoScrollController,
            itemCount: allPosts.length + 1,
            itemBuilder: (context, index) {
              if (index == allPosts.length) {
                return UserPostsHelper.hasMore[widget.profileEntity.username] ==
                        true
                    ? Center(child: CircularProgressLoading())
                    : SizedBox.shrink();
              }
              final post = allPosts[index];
              return AutoScrollTag(
                key: ValueKey(index),
                controller: autoScrollController,
                index: index,
                child: PostWidget(key: ValueKey(post.id), postEntity: post),
              );
            },
          );
        },
      ),
    );
  }
}
