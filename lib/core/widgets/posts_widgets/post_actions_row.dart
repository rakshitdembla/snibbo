import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/local_data_manager/post_interaction_manager.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_action_icon.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/comments/show_comments_sheet.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/animated_like_bloc/animated_like_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/animated_like_bloc/animated_like_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/animated_like_bloc/animated_like_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/dislike_post_bloc/dislike_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/dislike_post_bloc/dislike_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/like_post_bloc/like_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/like_post_bloc/like_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/save_post/remove_saved_post_bloc/remove_saved_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/save_post/remove_saved_post_bloc/remove_saved_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/save_post/save_post_animation_bloc/save_post_animation_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/save_post/save_post_animation_bloc/save_post_animation_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/save_post/save_post_animation_bloc/save_post_animation_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/save_post/save_post_bloc/save_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/save_post/save_post_bloc/save_post_events.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class PostActionsRow extends StatelessWidget {
  final PostEntity post;
  const PostActionsRow({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.025,
        right: width * 0.02,
        top: height * 0.008,
        bottom: height * 0.01,
      ),
      child: Row(
        children: [
          BlocBuilder<AnimatedLikeBloc, AnimatedLikeStates>(
            buildWhen: (previous, current) {
              if (current is ShowLikeState) {
                return current.postId == post.id;
              } else if (current is HideLikeState) {
                return current.postid == post.id;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              return PostActionIcon(
                onTap: () {
                  if (PostInteractionManager.likeStatus[post.id] == true) {
                    PostInteractionManager.likeStatus[post.id] = false;
                    PostInteractionManager.likeCount[post.id] =
                        (PostInteractionManager.likeCount[post.id] ?? 0) - 1;
                    BlocProvider.of<DislikePostBloc>(
                      context,
                    ).add(DislikePostPressed(postId: post.id));

                    BlocProvider.of<AnimatedLikeBloc>(
                      context,
                    ).add(TappedDislike(postId: post.id));
                  } else {
                    PostInteractionManager.likeStatus[post.id] = true;
                    PostInteractionManager.likeCount[post.id] =
                        (PostInteractionManager.likeCount[post.id] ?? 0) + 1;

                    BlocProvider.of<LikePostBloc>(
                      context,
                    ).add(LikePostPressed(postId: post.id));

                    BlocProvider.of<AnimatedLikeBloc>(
                      context,
                    ).add(DoubleTapLike(postId: post.id));
                  }
                },
                count:
                    (PostInteractionManager.likeCount[post.id] ?? 0).toString(),
                icon:
                    PostInteractionManager.likeStatus[post.id] == true
                        ? (state is ShowLikeState && state.postId == post.id)
                            ? CommonIcon._(
                              icon: LineIcons.heartAlt,
                              iconColor: Colors.red,
                            ).animate().shake(duration: 700.ms)
                            : CommonIcon._(
                              icon: LineIcons.heartAlt,
                              iconColor: Colors.red,
                            )
                        : CommonIcon._(icon: LineIcons.heart),
              );
            },
          ),
          SizedBox(width: width * 0.04),
          PostActionIcon(
            onTap: () {
              BlocProvider.of<GetPostCommentsBloc>(context).add(FetchPostComments(postId: post.id));
              ShowCommentsSheet.show(context: context, isDark: isDark,post: post);
            },
            count: post.commentsLength.toString(),
            icon: CommonIcon._(icon: LineIcons.comments),
          ),
          SizedBox(width: width * 0.04),

          PostActionIcon(
            onTap: () {},
            count: "",
            icon: CommonIcon._(icon: LineIcons.telegramPlane),
          ),
          Spacer(),
          BlocBuilder<SavePostAnimationBloc, SavePostAnimationStates>(
            buildWhen: (previous, current) {
              if (current is ShowSaveAnimationState) {
                return current.postId == post.id;
              } else if (current is HideSaveAnimationState) {
                return current.postId == post.id;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              return PostActionIcon(
                onTap: () {
                  if (PostInteractionManager.savedStatus[post.id] == true) {
                    PostInteractionManager.savedStatus[post.id] = false;
                    BlocProvider.of<SavePostAnimationBloc>(
                      context,
                    ).add(TapUnsavePost(postId: post.id));
                    BlocProvider.of<RemoveSavedPostBloc>(
                      context,
                    ).add(RemoveSavedPostRequested(postId: post.id));
                  } else {
                    PostInteractionManager.savedStatus[post.id] = true;
                    BlocProvider.of<SavePostAnimationBloc>(
                      context,
                    ).add(TapSavePost(postId: post.id));
                    BlocProvider.of<SavePostBloc>(
                      context,
                    ).add(SavePostRequested(postId: post.id));
                  }
                },
                count: "",
                icon:
                    PostInteractionManager.savedStatus[post.id] == true
                        ? (state is ShowSaveAnimationState &&
                                state.postId == post.id)
                            ? CommonIcon._(
                              icon: Icons.bookmark_rounded
                            ).animate().scale(
                              duration: 400.ms,
                              curve: Curves.elasticOut,
                              begin: Offset(0.9, 0.9),
                              end: Offset(1.2, 1.2),
                            )
                            : CommonIcon._(icon: Icons.bookmark_rounded)
                        : CommonIcon._(icon: LucideIcons.bookmark,iconSize: width * 0.065,),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CommonIcon extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  const CommonIcon._({required this.icon, this.iconColor,this.iconSize});

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final width = UiUtils.screenWidth(context);
    final nullColor = iconColor == null;
    return Icon(
      icon,
      color:
          nullColor
              ? isDark
                  ? MyColors.white
                  : MyColors.black
              : iconColor,
      size: iconSize ?? width * 0.07,
    );
  }
}
