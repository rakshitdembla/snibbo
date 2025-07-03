import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/local_data_manager/post_interaction_manager.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/comments/reply_delete_icon.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/toogle_reply_like_bloc/toogle_reply_like_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/toogle_reply_like_bloc/toogle_reply_like_states.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/toogle_reply_like_bloc/toogle_reply_like_bloc.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class UserReplyWidget extends StatefulWidget {
  final CommentReplyEntity replyEntity;
  final String commendId;
  final String postId;

  const UserReplyWidget({
    super.key,
    required this.replyEntity,
    required this.commendId,
    required this.postId,
  });

  @override
  State<UserReplyWidget> createState() => _UserReplyWidgetState();
}

class _UserReplyWidgetState extends State<UserReplyWidget> {
  @override
  void initState() {
    PostInteractionManager.replyLikeStatus.putIfAbsent(
      widget.replyEntity.id,
      () => widget.replyEntity.isLikedByMe,
    );
    PostInteractionManager.replyLikeCount.putIfAbsent(
      widget.replyEntity.id,
      () => widget.replyEntity.replyLikes,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;

    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.02,
        left: width * 0.07,
        right: width * 0.02,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserCircularProfileWidget(
            username: widget.replyEntity.userId.username,
            profileUrl: widget.replyEntity.userId.profilePicture,
            margins: EdgeInsets.only(right: width * 0.012),
            storySize: 0.035,
            isStatic: false,
            isAllStoriesViewed: widget.replyEntity.userId.isAllStoriesViewed,
            hasActiveStories: widget.replyEntity.userId.hasActiveStories,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.router.push(UserProfileScreenRoute(
                          username: widget.replyEntity.userId.username));
                      },
                      child: Text(
                        widget.replyEntity.userId.username,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: height * 0.012,
                        ),
                      ),
                    ),
                    Text(
                      "  ${ServicesUtils.toTimeAgo(widget.replyEntity.createdAt)}",
                      style: TextStyle(
                        color: MyColors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: height * 0.010,
                      ),
                    ),
                    SizedBox(width: width * 0.005),
                    ReplyDeleteIcon(
                      isMyReply: widget.replyEntity.isMyReply,
                      commentId: widget.commendId,
                      replyId: widget.replyEntity.id,
                      postId: widget.postId,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.0015),
                Text(
                  widget.replyEntity.replyContent,
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: height * 0.0135,
                  ),
                ),
              ],
            ),
          ),

          // Toggle Reply Like Bloc Builder
          BlocBuilder<ToggleReplyLikeBloc, ToggleReplyLikeState>(
            buildWhen: (previous, current) {
              if (current is ToggleReplyLikeLoading &&
                  current.replyId == widget.replyEntity.id) {
                return true;
              }
              if (current is ToggleReplyLikeSuccess &&
                  current.replyId == widget.replyEntity.id) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(top: height * 0.005),
                child: GestureDetector(
                  onLongPress: () {
                    context.router.push(
                      ReplyLikedUsersScreenRoute(reply: widget.replyEntity),
                    );
                  },
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          final isReplyLiked =
                              PostInteractionManager.replyLikeStatus[widget
                                  .replyEntity
                                  .id] ==
                              true;
                          final toggleLikeBloc =
                              context.read<ToggleReplyLikeBloc>();

                          if (isReplyLiked) {
                            PostInteractionManager.replyLikeCount[widget
                                    .replyEntity
                                    .id] =
                                (PostInteractionManager.replyLikeCount[widget
                                        .replyEntity
                                        .id] ??
                                    1) -
                                1;
                            PostInteractionManager.replyLikeStatus[widget
                                    .replyEntity
                                    .id] =
                                false;
                            toggleLikeBloc.add(
                              SubmitToggleReplyLikeEvent(
                                replyId: widget.replyEntity.id,
                                isDislike: true,
                              ),
                            );
                          } else {
                            PostInteractionManager.replyLikeCount[widget
                                    .replyEntity
                                    .id] =
                                (PostInteractionManager.replyLikeCount[widget
                                        .replyEntity
                                        .id] ??
                                    0) +
                                1;
                            PostInteractionManager.replyLikeStatus[widget
                                    .replyEntity
                                    .id] =
                                true;
                            toggleLikeBloc.add(
                              SubmitToggleReplyLikeEvent(
                                replyId: widget.replyEntity.id,
                                isDislike: false,
                              ),
                            );
                          }
                        },
                        child: Icon(
                          PostInteractionManager.replyLikeStatus[widget
                                      .replyEntity
                                      .id] ==
                                  true
                              ? LineIcons.heartAlt
                              : LineIcons.heart,
                          color:
                              PostInteractionManager.replyLikeStatus[widget
                                          .replyEntity
                                          .id] ==
                                      true
                                  ? Colors.red
                                  : isDark
                                  ? MyColors.primary
                                  : MyColors.darkPrimary,
                          size: height * 0.017,
                        ),
                      ),
                      SizedBox(height: height * 0.005),
                      Text(
                        PostInteractionManager
                            .replyLikeCount[widget.replyEntity.id]
                            .toString(),
                        style: TextStyle(
                          fontSize: width * 0.023,
                          color: MyColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
