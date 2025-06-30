import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_widget.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_states.dart';
import 'package:snibbo_app/features/user/presentation/helpers/user_saved_posts_helper.dart';

@RoutePage()
class SavedPostsViewScreen extends StatefulWidget {
  final ProfileEntity profileEntity;
  final int initialIndex;

  const SavedPostsViewScreen({
    super.key,
    required this.profileEntity,
    required this.initialIndex,
  });

  @override
  State<SavedPostsViewScreen> createState() => _SavedPostsViewScreenState();
}

class _SavedPostsViewScreenState extends State<SavedPostsViewScreen> {
  late UserSavedPostsPaginationBloc userSavedPostsBloc;
  late AutoScrollController autoScrollController;

  void _listener() {
    if (autoScrollController.position.pixels ==
        autoScrollController.position.maxScrollExtent) {
      final hasMoreUserSavedPosts =
          UserSavedPostsHelper.hasMore[widget.profileEntity.username] == true;
      final userSavedPostsLoading =
          UserSavedPostsHelper.isLoading[widget.profileEntity.username] == true;

      if (hasMoreUserSavedPosts && !userSavedPostsLoading) {
        userSavedPostsBloc.add(
          LoadMoreSavedPosts(username: widget.profileEntity.username),
        );
      }
    }
  }

  void scrollToIndex() async {
    await autoScrollController.scrollToIndex(
      widget.initialIndex,
      preferPosition: AutoScrollPosition.begin,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void initState() {
    userSavedPostsBloc = context.read<UserSavedPostsPaginationBloc>();
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
        title: const Text("Saved Posts"),
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<
        UserSavedPostsPaginationBloc,
        UserSavedPostsPaginationStates
      >(
        buildWhen: (previous, current) {
          if (current is UserSavedPostsPaginationLoaded) {
            return current.username == widget.profileEntity.username;
          } else if (current is RefreshUserSavedPostsPagination) {
            return current.username == widget.profileEntity.username;
          }
          return false;
        },
        builder: (context, state) {
          if (state is RefreshUserSavedPostsPagination) {
            return Center(child: CircularProgressLoading());
          }
          final allPosts =
              UserSavedPostsHelper.posts[widget.profileEntity.username];

          if (allPosts == null) {
            return SizedBox.shrink();
          }

          return ListView.builder(
            controller: autoScrollController,
            itemCount: allPosts.length + 1,
            itemBuilder: (context, index) {
              if (index == allPosts.length) {
                return UserSavedPostsHelper.hasMore[widget
                            .profileEntity
                            .username] ==
                        true
                    ? const Center(child: CircularProgressLoading())
                    : const SizedBox.shrink();
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
