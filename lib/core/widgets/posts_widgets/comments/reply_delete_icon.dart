import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_replies_bloc/comment_replies_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_replies_bloc/comment_replies_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/delete_reply_bloc/delete_reply_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/delete_reply_bloc/delete_reply_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/delete_reply_bloc/delete_reply_states.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class ReplyDeleteIcon extends StatelessWidget {
  final bool isMyReply;
  final String replyId;
  final String commentId;
  final String postId;
  const ReplyDeleteIcon({
    super.key,
    required this.isMyReply,
    required this.commentId,
    required this.replyId,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return isMyReply
        ? BlocConsumer<DeleteReplyBloc, DeleteReplyState>(
          listenWhen: (previous, current) {
            if (current is DeleteReplySuccess && current.replyId == replyId) {
              return true;
            } else if (current is DeleteReplyFailure &&
                current.replyId == replyId) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            if (state is DeleteReplySuccess) {
              UiUtils.showToast(
                title: state.title,
                isDark: isDark,
                description: state.description,
                context: context,
                isSuccess: true,
                isWarning: false,
              );

              BlocProvider.of<GetCommentRepliesBloc>(
                context,
              ).add(RemoveCommentReply(commentId: commentId, replyId: state.replyId));
            } else if (state is DeleteReplyFailure) {
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
            if (current is DeleteReplySuccess && current.replyId == replyId) {
              return true;
            } else if (current is DeleteReplyFailure &&
                current.replyId == replyId) {
              return true;
            } else if (current is DeleteReplyLoading &&
                current.replyId == replyId) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if (state is DeleteReplyLoading) {
              return CircularProgressLoading(androidScaleSize: height * 0.00035,iosScaleSize: height * 0.0007,);
            }
            return GestureDetector(
              onTap: () {
                BlocProvider.of<DeleteReplyBloc>(
                  context,
                ).add(SubmitDeleteReplyEvent(replyId: replyId));
              },
              child: Icon(
                LineIcons.alternateTrashAlt,
                size: height * 0.017,
                color: MyColors.secondaryDense,
              ),
            );
          },
        )
        : SizedBox.shrink();
  }
}
