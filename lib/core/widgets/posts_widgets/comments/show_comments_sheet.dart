import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/bottom_modal_sheet.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/user_comment_widget.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_states.dart';

class ShowCommentsSheet {
  static void show({
    required BuildContext context,
    required bool isDark,
    required String postId,
  }) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    final GetPostCommentsBloc getPostCommentsBloc =
        context.read<GetPostCommentsBloc>();

    final controller = ScrollController();

    void listener() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (getPostCommentsBloc.hasMore && !getPostCommentsBloc.isLoading) {
          getPostCommentsBloc.add(LoadMorePostComments(postId: postId));
        }
      }
    }

    controller.addListener(listener);

    MyBottomModalSheet.show(
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
            if (current is GetPostCommentsLoaded && current.postId == postId) {
              return true;
            } else if (current is GetPostCommentsError &&
                current.postId == postId) {
              return true;
            } else if (current is GetPostCommentsPaginationError &&
                current.postId == postId) {
              return true;
            }
            return false;
          },

          buildWhen: (previous, current) {
            if (current is GetPostCommentsLoaded && current.postId == postId) {
              return true;
            } else if (current is GetPostCommentsError &&
                current.postId == postId) {
              return true;
            } else if (current is GetPostCommentsLoading && current.postId == postId) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            controller.addListener(listener);
            if (state is GetPostCommentsLoaded) {
              return SizedBox(
                width: width,
                height: height * 0.6,
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.013),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Comments",
                        style: TextStyle(
                          fontSize: width * 0.037,
                          fontWeight: FontWeight.w700,
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
                      getPostCommentsBloc.allComments.isEmpty
                          ? Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.18,
                            ),
                            child: Center(child: Text("No comments yet")),
                          )
                          : Expanded(
                            child: ListView.builder(
                              controller: controller,
                              padding: EdgeInsetsGeometry.only(
                                bottom:
                                    getPostCommentsBloc.hasMore
                                        ? 0
                                        : UiUtils.bottomNavBar(
                                          context: context,
                                        ),
                              ),
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
                                return UserCommentWidget(postId: postId,
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
                    ],
                  ),
                ),
              );
            } else if (state is GetPostCommentsError) {
              return Center(child: Text("Failed to load comments"));
            }

            return Center(child: CircularProgressLoading());
          },
        );
      },
    );
  }
}
