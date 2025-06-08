import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/comment_delete_icon.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_interaction_manager.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/replies_list_widget.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_replies_bloc/comment_replies_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/toogle_comment_like_bloc/toogle_comment_like_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/toogle_comment_like_bloc/toogle_comment_like_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/toogle_comment_like_bloc/toogle_comment_like_states.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class UserCommentWidget extends StatefulWidget {
  final PostCommentEntity commentEntity;
  final String postId;
  const UserCommentWidget({super.key, required this.commentEntity,required this.postId});

  @override
  State<UserCommentWidget> createState() => _UserCommentWidgetState();
}

class _UserCommentWidgetState extends State<UserCommentWidget> {
  late GetCommentRepliesBloc getCommentRepliesBloc;

  @override
  void initState() {
    getCommentRepliesBloc =
        context.read<GetCommentRepliesBloc>(); // Initialize getComments BLoc
    PostInteractionManager.commentLikeStatus.putIfAbsent(
      widget.commentEntity.id,
      () => widget.commentEntity.isLikedByMe,
    ); // Initialize is comment liked by me in cache
    PostInteractionManager.commentLikeCount.putIfAbsent(
      widget.commentEntity.id,
      () => widget.commentEntity.commentLikes,
    ); // Initialize likes vount in cache
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --> User Profile / User Story Widget
              UserCircularProfileWidget(
                profileUrl: widget.commentEntity.userId.profilePicture,
                margins: EdgeInsets.only(right: width * 0.016),
                storySize: 0.04,
                greyBorder:
                    widget.commentEntity.userId.isAllStoriesViewed != null &&
                            widget.commentEntity.userId.isAllStoriesViewed ==
                                true
                        ? true
                        : false,
                showBorder:
                    widget.commentEntity.userId.hasActiveStories != null &&
                            widget.commentEntity.userId.hasActiveStories == true
                        ? true
                        : false,
              ),
              // --> Comment Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // -> Username
                        Text(
                          widget.commentEntity.userId.username,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: height * 0.013,
                          ),
                        ),
                        // -> When comment was created
                        Text(
                          "  ${ServicesUtils.toTimeAgo(widget.commentEntity.createdAt)}",
                          style: TextStyle(
                            color: MyColors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: height * 0.011,
                          ),
                        ),
                        SizedBox(width: width * 0.01,),

                        CommentDeleteIcon(
                          isMyComment: widget.commentEntity.isMyComment,
                          commentId: widget.commentEntity.id,postId: widget.postId ,
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.0018),
                    // -> Main comment content
                    Text(
                      widget.commentEntity.commentContent,
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: height * 0.0145,
                      ),
                    ),
                    SizedBox(height: height * 0.003),
                    // -> Reply Button
                    Text(
                      "Reply",
                      style: TextStyle(
                        color: MyColors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: height * 0.012,
                      ),
                    ),
                  ],
                ),
              ),
              // -> Toogle Comment Like Builder
              BlocBuilder<ToggleCommentLikeBloc, ToggleCommentLikeState>(
                buildWhen: (previous, current) {
                  // -> Rebuild when like/dislike is triggered for this specific comment
                  if (current is ToogleCommentLikeLoading &&
                      current.commentId == widget.commentEntity.id) {
                    return true;
                  }
                  if (current is ToggleCommentLikeSuccess &&
                      current.commentId == widget.commentEntity.id) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.02,
                      right: width * 0.01,
                      left: width * 0.05,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            final isCommentLiked =
                                PostInteractionManager.commentLikeStatus[widget
                                    .commentEntity
                                    .id] ==
                                true;
                            final toogleLikeBloc =
                                context.read<ToggleCommentLikeBloc>();

                            // -> Dispatch like or dislike event based on current status
                            if (isCommentLiked) {
                              // -> Decrease like count and update cache
                              PostInteractionManager.commentLikeCount[widget
                                      .commentEntity
                                      .id] =
                                  (PostInteractionManager
                                          .commentLikeCount[widget
                                          .commentEntity
                                          .id] ??
                                      1) -
                                  1;
                              PostInteractionManager.commentLikeStatus[widget
                                      .commentEntity
                                      .id] =
                                  false;
                              toogleLikeBloc.add(
                                SubmitToggleCommentLikeEvent(
                                  commentId: widget.commentEntity.id,
                                  isDislike: true,
                                ),
                              );
                            } else {
                              // -> Increase like count and update cache
                              PostInteractionManager.commentLikeCount[widget
                                      .commentEntity
                                      .id] =
                                  (PostInteractionManager
                                          .commentLikeCount[widget
                                          .commentEntity
                                          .id] ??
                                      0) +
                                  1;
                              PostInteractionManager.commentLikeStatus[widget
                                      .commentEntity
                                      .id] =
                                  true;

                              toogleLikeBloc.add(
                                SubmitToggleCommentLikeEvent(
                                  commentId: widget.commentEntity.id,
                                  isDislike: false,
                                ),
                              );
                            }
                          },
                          child: Icon(
                            // -> Show liked icon if comment is liked
                            PostInteractionManager.commentLikeStatus[widget
                                        .commentEntity
                                        .id] ==
                                    true
                                ? LineIcons.heartAlt
                                : LineIcons.heart,
                            color:
                                PostInteractionManager.commentLikeStatus[widget
                                            .commentEntity
                                            .id] ==
                                        true
                                    ? Colors.red
                                    : isDark
                                    ? MyColors.primary
                                    : MyColors.darkPrimary,
                            size: height * 0.018,
                          ),
                        ),
                        SizedBox(height: height * 0.006),
                        // -> Display number of likes on comment
                        Text(
                          PostInteractionManager
                              .commentLikeCount[widget.commentEntity.id]
                              .toString(),
                          style: TextStyle(
                            fontSize: width * 0.025,
                            color: MyColors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          RepliesListWidget(
            postId: widget.postId,
            replies: widget.commentEntity.commentReplies,
            commentId: widget.commentEntity.id,
            getCommentRepliesBloc: getCommentRepliesBloc,
          ),
        ],
      ),
    );
  }
}
