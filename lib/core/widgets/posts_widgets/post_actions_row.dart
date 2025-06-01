import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_action_icon.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/show_comments_sheet.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/animated_like_bloc/animated_like_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/animated_like_bloc/animated_like_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/animated_like_bloc/animated_like_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/toogle_like_bloc/toogle_like_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/toogle_like_bloc/toogle_like_events.dart';
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
        left: width * 0.023,
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
              final blocLike =
                  context.read<AnimatedLikeBloc>().showLiked[post.id];
              final showLiked = blocLike != null && blocLike == true;
              return PostActionIcon(
                onTap: () {
                  if (showLiked) {
                    //@ Remove Ui Shown Like & DisLike
                    BlocProvider.of<AnimatedLikeBloc>(
                      context,
                    ).add(RemoveShownLike(postId: post.id));

                    BlocProvider.of<ToogleLikeBloc>(
                      context,
                    ).add(ToogleLike(postId: post.id, isDislike: true));

                    return;
                  }

                  //@ Show Ui Like Animation & Add Like
                  BlocProvider.of<AnimatedLikeBloc>(
                    context,
                  ).add(DoubleTapLike(postId: post.id));
                  BlocProvider.of<ToogleLikeBloc>(
                    context,
                  ).add(ToogleLike(postId: post.id, isDislike: false));
                },
                count: post.postLikes.length.toString(),
                icon:
                    showLiked
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
              ShowCommentsSheet.show(context: context, isDark: isDark);
            },
            count: post.postComments.length.toString(),
            icon: CommonIcon._(icon: LineIcons.comments),
          ),
          SizedBox(width: width * 0.04),

          PostActionIcon(
            onTap: () {},
            count: "",
            icon: CommonIcon._(icon: LineIcons.telegramPlane),
          ),
          Spacer(),
          PostActionIcon(
            onTap: () {},
            count: "",
            icon: CommonIcon._(icon: LineIcons.bookmark),
          ),
        ],
      ),
    );
  }
}

class CommonIcon extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  const CommonIcon._({required this.icon, this.iconColor});

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
      size: width * 0.075,
    );
  }
}
