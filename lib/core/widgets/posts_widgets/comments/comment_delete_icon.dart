import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/delete_comment_bloc/delete_comment_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/delete_comment_bloc/delete_comment_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/delete_comment_bloc/delete_comment_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_events.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class CommentDeleteIcon extends StatelessWidget {
  final bool isMyComment;
  final String commentId;
  final String postId;
  const CommentDeleteIcon({
    super.key,
    required this.isMyComment,
    required this.commentId,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return isMyComment
        ? BlocConsumer<DeleteCommentBloc, DeleteCommentState>(
          listenWhen: (previous, current) {
            if (current is DeleteCommentSuccess &&
                current.commentId == commentId) {
              return true;
            } else if (current is DeleteCommentFailure &&
                current.commentId == commentId) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            if (state is DeleteCommentSuccess) {
              UiUtils.showToast(
                title: state.title,
                isDark: isDark,
                description: state.description,
                context: context,
                isSuccess: true,
                isWarning: false,
              );

              BlocProvider.of<GetPostCommentsBloc>(context).add(
                DeletePostComment(postId: postId, commentId: state.commentId),
              );
            } else if (state is DeleteCommentFailure) {
              UiUtils.showToast(
                title: state.title,
                isDark: isDark,
                description: state.description,
                context: context,
                isSuccess: true,
                isWarning: false,
              );
            }
          },
          buildWhen: (previous, current) {
            if (current is DeleteCommentSuccess &&
                current.commentId == commentId) {
              return true;
            } else if (current is DeleteCommentFailure &&
                current.commentId == commentId) {
              return true;
            } else if (current is DeleteCommentLoading &&
                current.commentId == commentId) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if (state is DeleteCommentLoading) {
              return SecondaryCircularProgress(scaleSize: height * 0.00065);
            }
            return GestureDetector(
              onTap: () {
                BlocProvider.of<DeleteCommentBloc>(
                  context,
                ).add(SubmitDeleteCommentEvent(commentId: commentId));
              },
              child: Icon(
                LineIcons.alternateTrash,
                size: height * 0.018,
                color: MyColors.secondaryDense,
              ),
            );
          },
        )
        : SizedBox.shrink();
  }
}
