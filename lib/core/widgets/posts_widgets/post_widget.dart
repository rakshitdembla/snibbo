import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/animated_like.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_interaction_manager.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_actions_row.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_captions.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/animated_like_bloc/animated_like_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/animated_like_bloc/animated_like_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/animated_like_bloc/animated_like_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/like_post_bloc/like_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/like_post_bloc/like_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/posts/post_menu_bottom_sheet.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class PostWidget extends StatefulWidget {
  final PostEntity postEntity;
  const PostWidget({super.key, required this.postEntity});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late UserEntity postUser;
  late PostEntity post;

  @override
  void initState() {
    super.initState();
    postUser = widget.postEntity.userId;
    post = widget.postEntity;
    PostInteractionManager.likeStatus.putIfAbsent(
      post.id,
      () => post.isLikedByMe,
    );
    PostInteractionManager.likeCount.putIfAbsent(
      post.id,
      () => post.likesLength,
    );
    PostInteractionManager.savedStatus.putIfAbsent(
      post.id,
      () => post.isSavedByMe,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: width * 0.013,
            bottom: height * 0.003,
            top: height * 0.015,
          ),
          child: Row(
            children: [
              UserCircularProfileWidget(
                showBorder: false,
                greyBorder: false,
                profileUrl: postUser.profilePicture.toString(),
                storySize: 0.055,
                margins: EdgeInsets.only(right: width * 0.01),
              ),
              GestureDetector(
                onTap: () {
                  // context.router.push(ProfileViewRoute());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postUser.name,
                      style: TextStyle(
                        fontSize: width * 0.033,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: height * 0.0025),
                    Text(
                      postUser.username,
                      style: TextStyle(
                        fontSize: width * 0.030,
                        color: MyColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  PostMenuBottomSheet.call(context: context, isDark: isDark);
                },
                icon: Icon(
                  Icons.more_vert,
                  color: isDark ? MyColors.white : MyColors.black,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onDoubleTap: () async {
            BlocProvider.of<AnimatedLikeBloc>(
              context,
            ).add(DoubleTapLike(postId: widget.postEntity.id));

            if (PostInteractionManager.likeStatus[post.id] == false) {
              PostInteractionManager.likeStatus[post.id] = true;
              PostInteractionManager.likeCount[post.id] =
                  (PostInteractionManager.likeCount[post.id] ?? 0) + 1;
              BlocProvider.of<LikePostBloc>(
                context,
              ).add(LikePostPressed(postId: widget.postEntity.id));
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                post.postContent,
                width: width,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return UiUtils.showShimmerBuilder(
                    wasSynchronouslyLoaded: wasSynchronouslyLoaded,
                    frame: frame,
                    child: child,
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    MyAssets.demoUser, //@ error builder
                    width: width,
                    frameBuilder: (
                      context,
                      child,
                      frame,
                      wasSynchronouslyLoaded,
                    ) {
                      return UiUtils.showShimmerBuilder(
                        wasSynchronouslyLoaded: wasSynchronouslyLoaded,
                        frame: frame,
                        child: child,
                      );
                    },
                  );
                },
              ),
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
                  final bool showAnimation =
                      state is ShowLikeState && state.postId == post.id;
                  if (showAnimation) {
                    return AnimatedLike(
                      widget: Icon(
                        LineIcons.heartAlt,
                        color: Colors.redAccent,
                        size: width * 0.3,
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
        PostActionsRow(post: post),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostCaptions(
                postCaption: post.postCaption.toString(),
                username: postUser.username,
              ),
              SizedBox(height: height * 0.0020),
              Text(
                ServicesUtils.toTimeAgo(post.createdAt),
                style: TextStyle(color: MyColors.grey, fontSize: width * 0.028),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
