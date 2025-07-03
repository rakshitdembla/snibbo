import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/animated_like.dart';
import 'package:snibbo_app/core/local_data_manager/post_interaction_manager.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_actions_row.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_captions.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/animated_like_bloc/animated_like_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/animated_like_bloc/animated_like_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/animated_like_bloc/animated_like_states.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/like_post_bloc/like_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/like_post_bloc/like_post_events.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_menu_bottom_sheet.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class PostWidget extends StatefulWidget {
  final PostEntity postEntity;
  const PostWidget({super.key, required this.postEntity});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late UserEntity postUser;
  late PostEntity post;
  bool showShimmer = true;

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

    PostInteractionManager.postCommentCount.putIfAbsent(
      post.id,
      () => post.commentsLength,
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
                isAllStoriesViewed: postUser.isAllStoriesViewed,
                isStatic: false,
                username: postUser.username,
                hasActiveStories: postUser.hasActiveStories,
                profileUrl: postUser.profilePicture.toString(),
                storySize: 0.055,
                margins: EdgeInsets.only(right: width * 0.015),
              ),
              GestureDetector(
                onTap: () {
                  context.router.push(
                    UserProfileScreenRoute(
                      username: widget.postEntity.userId.username,
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showShimmer
                        ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            width: width * 0.23,
                            height: height * 0.015,
                          ),
                        )
                        : Text(
                          postUser.name,
                          style: TextStyle(
                            fontSize: width * 0.033,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    SizedBox(height: height * 0.0025),
                    showShimmer
                        ? Padding(
                          padding: EdgeInsets.only(top: height * 0.006),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              width: width * 0.18,
                              height: height * 0.013,
                            ),
                          ),
                        )
                        : Text(
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
                  PostMenuBottomSheet.call(
                    context: context,
                    isDark: isDark,
                    postId: post.id,
                  );
                },
                icon: Icon(
                  Icons.more_vert,
                  color: isDark ? MyColors.white : MyColors.black,
                ),
              ),
              post.isMyPost
                  ? IconButton(
                    onPressed: () {
                      context.router.push(
                        UpdatePostScreenRoute(
                          username: post.userId.username,
                          postId: post.id,
                          imageUrl: post.postContent,
                          initialCaption: post.postCaption.toString(),
                        ),
                      );
                    },
                    icon: Icon(
                      LineIcons.edit,
                      color: isDark ? MyColors.white : MyColors.black,
                    ),
                  )
                  : SizedBox.shrink(),
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
          onLongPress: () {
            context.router.push(PostLikedUsersScreenRoute(post: post));
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                post.postContent,
                width: width,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded || frame != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {
                          showShimmer = false;
                        });
                      }
                    });
                    return child;
                  } else {
                    return SizedBox(
                      width: double.infinity,
                      height: height * 0.3,
                      child: UiUtils.showShimmer(),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    alignment: Alignment.center,
                    width: width,
                    height: height * 0.3,
                    color: const Color.fromARGB(11, 117, 117, 117),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Failed to load post"),
                        SizedBox(width: width * 0.01),
                        Icon(
                          LineIcons.exclamationCircle,
                          color: MyColors.secondaryDense,
                        ),
                      ],
                    ),
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
