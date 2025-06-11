import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/custom_user_tile.dart';
import 'package:snibbo_app/core/widgets/refresh_bar.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_liked_users/post_liked_users_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_liked_users/post_liked_users_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_liked_users/post_liked_users_states.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

@RoutePage()
class PostLikedUsersScreen extends StatefulWidget {
  final PostEntity post;
  const PostLikedUsersScreen({super.key, required this.post});

  @override
  State<PostLikedUsersScreen> createState() => _PostLikedUsersScreenState();
}

class _PostLikedUsersScreenState extends State<PostLikedUsersScreen> {
  late ScrollController _controller;
  late PostLikedUsersBloc postLikedUsersBloc;

  void _listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (postLikedUsersBloc.hasMore && !postLikedUsersBloc.isLoading) {
        postLikedUsersBloc.add(LoadMorePostLikedUsers(postId: widget.post.id));
      }
    }
  }

  @override
  void initState() {
    BlocProvider.of<PostLikedUsersBloc>(context).add(
      GetPostLikedUsers(postId: widget.post.id),
    );
    _controller = ScrollController();
    postLikedUsersBloc = context.read<PostLikedUsersBloc>();
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Liked by"),
      ),
      body: MyRefreshBar(
        onRefresh: () async {
          BlocProvider.of<PostLikedUsersBloc>(context)
            .add(GetPostLikedUsers(postId: widget.post.id));
        },
        widget: BlocConsumer<PostLikedUsersBloc, PostLikedUsersStates>(
          listenWhen: (previous, current) {
            if (current is PostLikedUsersError) {
              return current.postId == widget.post.id;
            } else if (current is PostLikedUsersPaginationError) {
              return current.postId == widget.post.id;
            }
            return false;
          },
          listener: (context, state) {
            if (state is PostLikedUsersError) {
              UiUtils.showToast(
                title: state.title,
                isDark: isDark,
                description: state.descrition,
                context: context,
                isSuccess: false,
                isWarning: false,
              );
            } else if (state is PostLikedUsersPaginationError) {
              UiUtils.showToast(
                title: state.title,
                isDark: isDark,
                description: state.descrition,
                context: context,
                isSuccess: false,
                isWarning: false,
              );
            }
          },
          buildWhen: (previous, current) {
            if (current is PostLikedUsersLoading) {
              return current.postId == widget.post.id;
            } else if (current is PostLikedUsersError) {
              return current.postId == widget.post.id;
            } else if (current is PostLikedUsersLoaded) {
              return current.postId == widget.post.id;
            } else if (current is PostLikedUsersPaginationSuccess) {
              return current.postId == widget.post.id;
            }
            return false;
          },
          builder: (context, state) {
            final postLikedUsersBloc = context.read<PostLikedUsersBloc>();

            if (state is PostLikedUsersLoading) {
              return const Center(child: CircularProgressLoading());
            } else if (state is PostLikedUsersError) {
              return const Center(child: Text("Something went wrong"));
            }

            return postLikedUsersBloc.allUsers.isEmpty
                ? const Center(child: Text("No Likes"))
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _controller,
                    itemCount: postLikedUsersBloc.allUsers.length + 1,
                    itemBuilder: (context, index) {
                      if (index == postLikedUsersBloc.allUsers.length) {
                        return postLikedUsersBloc.hasMore
                            ? const CircularProgressLoading()
                            : const SizedBox.shrink();
                      }
                      final user = postLikedUsersBloc.allUsers[index];
                      return CustomUserTile(
                        user: user,
                        onPopRefreshUsername: widget.post.userId.username,
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}