import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/bottom_modal_sheet.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/comments/comment_input_field.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/comments/reply_input_field.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/comments/user_comment_widget.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/input_field_mode_bloc/input_field_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/input_field_mode_bloc/input_field_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/input_field_mode_bloc/input_field_states.dart';
import 'package:snibbo_app/presentation/general/presentation/bloc/hide_bottom_nav_bloc/hide_bottom_nav_bloc.dart';
import 'package:snibbo_app/presentation/general/presentation/bloc/hide_bottom_nav_bloc/hide_bottom_nav_events.dart';

class ShowCommentsSheet {
  static void show({
    required BuildContext context,
    required bool isDark,
    required PostEntity post,
  }) async {
    BlocProvider.of<HideBottomNavBloc>(context).add(HideBottomNavBar());
    BlocProvider.of<InputFieldBloc>(context).add(ShowCommentField(post: post));
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    final GetPostCommentsBloc getPostCommentsBloc =
        context.read<GetPostCommentsBloc>();

    final controller = ScrollController();

    void listener() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (getPostCommentsBloc.hasMore && !getPostCommentsBloc.isLoading) {
          getPostCommentsBloc.add(LoadMorePostComments(postId: post.id));
        }
      }
    }

    controller.addListener(listener);

    await MyBottomModalSheet.show(
      isScrollControlled: true,
      context: context,
      isDark: isDark,
      builder: (context) {
        return BlocConsumer<GetPostCommentsBloc, GetPostCommentsStates>(
          listener: (context, state) {
            if (state is GetPostCommentsError) {
              UiUtils.showToast(
                title: state.title,
                isDark: isDark,
                description: state.description,
                context: context,
                isSuccess: false,
                isWarning: false,
              );
            } else if (state is GetPostCommentsPaginationError) {
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
          listenWhen: (previous, current) {
            if (current is GetPostCommentsLoaded && current.postId == post.id) {
              return true;
            } else if (current is GetPostCommentsError &&
                current.postId == post.id) {
              return true;
            } else if (current is GetPostCommentsPaginationError &&
                current.postId == post.id) {
              return true;
            }
            return false;
          },
          buildWhen: (previous, current) {
            if (current is GetPostCommentsLoaded && current.postId == post.id) {
              return true;
            } else if (current is GetPostCommentsError &&
                current.postId == post.id) {
              return true;
            } else if (current is GetPostCommentsLoading &&
                current.postId == post.id) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            controller.addListener(listener);

            return SizedBox(
              width: width,
              height: height * 0.6,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.013),
                    child: Text(
                      "Comments",
                      style: TextStyle(
                        fontSize: width * 0.037,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.0015),
                    child: Opacity(
                      opacity: 0.15,
                      child: Divider(
                        color: MyColors.grey,
                        thickness: 1.0.r,
                        radius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),

                  if (state is GetPostCommentsLoading) ...[
                    SizedBox(height: height * 0.265),
                    Center(child: CircularProgressLoading()),
                  ] else if (state is GetPostCommentsError)
                    Expanded(
                      child: Center(child: Text("Failed to load comments")),
                    )
                  else if (state is GetPostCommentsLoaded) ...[
                    Expanded(
                      child:
                          getPostCommentsBloc.allComments.isEmpty
                              ? Center(child: Text("No comments yet"))
                              : ListView.builder(
                                controller: controller,
                                itemCount:
                                    getPostCommentsBloc.allComments.length + 1,
                                itemBuilder: (context, index) {
                                  if (index ==
                                      getPostCommentsBloc.allComments.length) {
                                    return getPostCommentsBloc.hasMore
                                        ? Padding(
                                          padding: EdgeInsetsGeometry.only(
                                            bottom: UiUtils.bottomNavBar(
                                              context: context,
                                            ),
                                          ),
                                          child: CircularProgressLoading(),
                                        )
                                        : SizedBox.shrink();
                                  }
                                  final comment =
                                      getPostCommentsBloc.allComments[index];
                                  return UserCommentWidget(
                                    post: post,
                                    commentEntity: PostCommentEntity(
                                      id: comment.id,
                                      isMyComment: comment.isMyComment,
                                      isLikedByMe: comment.isLikedByMe,
                                      userId: comment.userId,
                                      commentContent: comment.commentContent,
                                      commentLikes: comment.commentLikes,
                                      commentReplies: comment.commentReplies,
                                      createdAt: comment.createdAt,
                                      updatedAt: comment.updatedAt,
                                      v: comment.v,
                                    ),
                                  );
                                },
                              ),
                    ),
                    BlocBuilder<InputFieldBloc, InputFieldState>(
                      builder: (context, state) {
                        if (state is ReplyFieldState) {
                          return ReplyInputField(
                            comment: state.comment,
                            post: post,
                          );
                        }
                        return CommentInputField(post: post);
                      },
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
    if (context.mounted) {
      BlocProvider.of<HideBottomNavBloc>(context).add(ShowBottomNavBar());
    }
  }
}
