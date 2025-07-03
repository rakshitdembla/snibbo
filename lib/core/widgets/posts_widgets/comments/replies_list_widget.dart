import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/comments/user_reply_widget.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_replies_bloc/comment_replies_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_replies_bloc/comment_replies_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_replies_bloc/comment_replies_states.dart';
import 'package:snibbo_app/core/local_data_manager/replies_storage_helper.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class RepliesListWidget extends StatefulWidget {
  final int replies;
  final String commentId;
  final String postId;

  const RepliesListWidget({
    super.key,
    required this.replies,
    required this.postId,
    required this.commentId,
  });

  @override
  State<RepliesListWidget> createState() => _RepliesListWidgetState();
}

class _RepliesListWidgetState extends State<RepliesListWidget> {
  bool showReplies = false;

  @override
  void initState() {
    super.initState();
    ReplyStorageHelper.repliesLength.putIfAbsent(
      widget.commentId,
      () => widget.replies,
    );

    if (ReplyStorageHelper.repliesLength[widget.commentId]! > 0) {
      ReplyStorageHelper.hasMore.putIfAbsent(widget.commentId, () => true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return BlocConsumer<GetCommentRepliesBloc, GetCommentRepliesStates>(
      listener: (context, state) {
        if (state is GetCommentRepliesError) {
          UiUtils.showToast(
            title: state.title,
            isDark: isDark,
            description: state.description,
            context: context,
            isSuccess: false,
            isWarning: false,
          );
        } else if (state is GetCommentRepliesLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              showReplies = true;
            });
          });
        }
      },
      listenWhen: (previous, current) {
        if (current is GetCommentRepliesError) {
          return current.commentId == widget.commentId;
        } else if (current is GetCommentRepliesLoaded) {
          return current.commentId == widget.commentId;
        }
        return false;
      },

      buildWhen: (previous, current) {
        if (current is GetCommentRepliesLoading) {
          return current.commentId == widget.commentId;
        } else if (current is GetCommentRepliesLoaded) {
          return current.commentId == widget.commentId;
        }
        return false;
      },
      builder: (context, state) {
        final allReplies = ReplyStorageHelper.replies[widget.commentId] ?? [];
        final initialRepliesLength =
            ReplyStorageHelper.repliesLength[widget.commentId]!;
        final showLoading = state is GetCommentRepliesLoading;
        if (initialRepliesLength > 0 || allReplies.isNotEmpty) {
          
          final hasMore = ReplyStorageHelper.hasMore[widget.commentId] == true;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -> Replies ListView Builder
              showReplies
                  ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allReplies.length,
                    itemBuilder: (context, index) {
                      final reply = allReplies[index];
                      return UserReplyWidget(
                        key: ValueKey(reply.id),
                        commendId: widget.commentId,
                        postId: widget.postId,
                        replyEntity: reply,
                      );
                    },
                  )
                  : SizedBox.shrink(),

              // Toggle Button for Show & Hide Replies
              Padding(
                padding: EdgeInsets.only(
                  left: width * 0.02,
                  top: height * 0.01,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (hasMore) {
                      BlocProvider.of<GetCommentRepliesBloc>(
                        context,
                      ).add(FetchCommentReplies(commentId: widget.commentId));
                      setState(() {
                        showReplies = true;
                      });
                    } else {
                      BlocProvider.of<GetCommentRepliesBloc>(
                        context,
                      ).add(ResetCommentsReplies(commentId: widget.commentId));
                      setState(() {
                        showReplies = false;
                      });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.08),
                    child: Row(
                      children: [
                        Text(
                          hasMore
                              ? initialRepliesLength - allReplies.length <= 0
                                  ? "- view replies"
                                  : "- view replies (${initialRepliesLength - allReplies.length})"
                              : "- hide replies",
                          style: TextStyle(
                            color:
                                isDark
                                    ? MyColors.darkRefresh
                                    : MyColors.refresh,
                            fontWeight: FontWeight.w500,
                            fontSize: height * 0.012,
                          ),
                        ),
                        showLoading
                            ? Padding(
                              padding: EdgeInsets.only(left: width * 0.01),
                              child: CircularProgressLoading(
                                androidScaleSize: width * 0.0006,
                                iosScaleSize: width * 0.001,
                              ),
                            )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
