import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/custom_user_tile.dart';
import 'package:snibbo_app/core/widgets/refresh_bar.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_liked_users_bloc/comment_liked_users_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_liked_users_bloc/comment_liked_users_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_liked_users_bloc/comment_liked_users_states.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

@RoutePage()
class CommentLikedUsersScreen extends StatefulWidget {
  final PostCommentEntity comment;
  const CommentLikedUsersScreen({super.key, required this.comment});

  @override
  State<CommentLikedUsersScreen> createState() => _CommentLikedUsersScreenState();
}

class _CommentLikedUsersScreenState extends State<CommentLikedUsersScreen> {
  late ScrollController _controller;
  late CommentLikedUsersBloc commentLikedUsersBloc;

  void _listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (commentLikedUsersBloc.hasMore && !commentLikedUsersBloc.isLoading) {
        commentLikedUsersBloc.add(LoadMoreCommentLikedUsers(commentId: widget.comment.id));
      }
    }
  }

  @override
  void initState() {
    BlocProvider.of<CommentLikedUsersBloc>(context).add(
      GetCommentLikedUsers(commentId: widget.comment.id),
    );
    _controller = ScrollController();
    commentLikedUsersBloc = context.read<CommentLikedUsersBloc>();
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
          BlocProvider.of<CommentLikedUsersBloc>(context)
              .add(GetCommentLikedUsers(commentId: widget.comment.id));
        },
        widget: BlocConsumer<CommentLikedUsersBloc, CommentLikedUsersStates>(
          listenWhen: (previous, current) {
            if (current is CommentLikedUsersError) {
              return current.commentId == widget.comment.id;
            } else if (current is CommentLikedUsersPaginationError) {
              return current.commentId == widget.comment.id;
            }
            return false;
          },
          listener: (context, state) {
            if (state is CommentLikedUsersError) {
              UiUtils.showToast(
                title: state.title,
                isDark: isDark,
                description: state.descrition,
                context: context,
                isSuccess: false,
                isWarning: false,
              );
            } else if (state is CommentLikedUsersPaginationError) {
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
            if (current is CommentLikedUsersLoading) {
              return current.commentId == widget.comment.id;
            } else if (current is CommentLikedUsersError) {
              return current.commentId == widget.comment.id;
            } else if (current is CommentLikedUsersLoaded) {
              return current.commentId == widget.comment.id;
            } else if (current is CommentLikedUsersPaginationSuccess) {
              return current.commentId == widget.comment.id;
            }
            return false;
          },
          builder: (context, state) {
            final commentLikedUsersBloc = context.read<CommentLikedUsersBloc>();

            if (state is CommentLikedUsersLoading) {
              return const Center(child: CircularProgressLoading());
            } else if (state is CommentLikedUsersError) {
              return const Center(child: Text("Something went wrong"));
            }

            return commentLikedUsersBloc.allUsers.isEmpty
                ? const Center(child: Text("No Likes"))
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _controller,
                    itemCount: commentLikedUsersBloc.allUsers.length + 1,
                    itemBuilder: (context, index) {
                      if (index == commentLikedUsersBloc.allUsers.length) {
                        return commentLikedUsersBloc.hasMore
                            ? const CircularProgressLoading()
                            : const SizedBox.shrink();
                      }
                      final user = commentLikedUsersBloc.allUsers[index];
                      return CustomUserTile(
                        user: user,
                        onPopRefreshUsername: widget.comment.userId.username,
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
