import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/comments/user_reply_widget.dart';
import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_replies_bloc/comment_replies_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_replies_bloc/comment_replies_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_replies_bloc/comment_replies_states.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class RepliesListWidget extends StatefulWidget {
  final int replies;
  final String commentId;
  final String postId;
  final GetCommentRepliesBloc getCommentRepliesBloc;

  const RepliesListWidget({
    super.key,
    required this.replies,
    required this.postId,
    required this.commentId,
    required this.getCommentRepliesBloc,
  });

  @override
  State<RepliesListWidget> createState() => _RepliesListWidgetState();
}

class _RepliesListWidgetState extends State<RepliesListWidget> {
  bool showReplies = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return // --> Get Comment Replies BLoc Consumer
    widget.replies > 0
        ? BlocConsumer<GetCommentRepliesBloc, GetCommentRepliesStates>(
          // -> Listen When Validations (Get Comment Replies BLoc)
          listenWhen: (previous, current) {
            if (current is GetCommentRepliesLoaded &&
                current.commentId == widget.commentId) {
              return true;
            } else if (current is GetCommentRepliesLoaded &&
                current.commentId == widget.commentId) {
              return true;
            }
            return false;
          },

          // -> Listener for Get Comment Replies BLoc
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
            }
          },
          // -> Build When Validations (Get Comment Replies BLoc)
          buildWhen: (previous, current) {
            if (current is GetCommentRepliesLoaded &&
                current.commentId == widget.commentId) {
              return true;
            }
            return false;
          },
          // -> Builder for Get Comment Replies BLoc
          builder: (context, state) {
            final bool showLoading = widget.getCommentRepliesBloc.isLoading;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -> Replies ListView Builder
                showReplies
                    ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.getCommentRepliesBloc.allReplies.length,
                      itemBuilder: (context, index) {
                        final reply =
                            widget.getCommentRepliesBloc.allReplies[index];
                        // -> User Reply Widget
                        return UserReplyWidget(
                          commendId: widget.commentId,
                          postId: widget.postId,
                          replyEntity: CommentReplyEntity(
                            id: reply.id,
                            isMyReply: reply.isMyReply,
                            isLikedByMe: reply.isLikedByMe,
                            userId: reply.userId,
                            replyContent: reply.replyContent,
                            replyLikes: reply.replyLikes,
                            createdAt: reply.createdAt,
                            updatedAt: reply.updatedAt,
                            v: reply.v,
                          ),
                        );
                      },
                    )
                    : SizedBox.shrink(),
                // Toogle Button for Show & Hide Replies
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.02,
                    top: height * 0.01,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showReplies =
                            widget.getCommentRepliesBloc.hasMore ? true : false;
                      });
                      showReplies
                          ? widget.getCommentRepliesBloc.add(
                            FetchCommentReplies(commentId: widget.commentId),
                          )
                          : widget.getCommentRepliesBloc.add(
                            ResetCommentsReplies(),
                          );
                    },
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(left: width * 0.08),
                      child: Row(
                        children: [
                          Text(
                            widget.getCommentRepliesBloc.hasMore
                                ? "- View ${widget.replies - widget.getCommentRepliesBloc.allReplies.length} more reply"
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
                                child: SecondaryCircularProgress(
                                  scaleSize: width * 0.0015,
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
          },
        )
        : SizedBox.shrink();
  }
}
