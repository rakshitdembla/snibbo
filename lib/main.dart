import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/themedata.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/forget_password_bloc/forget_pass_bloc.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_post_bloc/create_post_bloc.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_story_bloc/create_story_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/delete_post/delete_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/update_post_bloc/update_post_bloc.dart';
import 'package:snibbo_app/features/explore/presentation/bloc/explore_posts_bloc/explore_posts_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_liked_users_bloc/comment_liked_users_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/comment_replies_bloc/comment_replies_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/create_comment_bloc/create_comment_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/create_reply_bloc/create_reply_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/delete_comment_bloc/delete_comment_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/delete_reply_bloc/delete_reply_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/get_comments_bloc/get_comments_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/input_field_mode_bloc/input_field_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/reply_liked_users_bloc/reply_liked_users_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/toogle_comment_like_bloc/toogle_comment_like_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/toogle_reply_like_bloc/toogle_reply_like_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/animated_like_bloc/animated_like_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/dislike_post_bloc/dislike_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/like_post_bloc/like_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_liked_users/post_liked_users_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/post_pagination_bloc/post_pagination_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/save_post/remove_saved_post_bloc/remove_saved_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/save_post/save_post_animation_bloc/save_post_animation_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/save_post/save_post_bloc/save_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/delete_story_bloc/delete_story_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_feed_bloc/get_feed_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/story_pagination_bloc/story_pagination_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/delete_story_bloc/get_user_stories_bloc/get_user_stories_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/story_viewers_bloc/story_viewers_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/view_story_bloc/view_story_bloc.dart';
import 'package:snibbo_app/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/features/user/presentation/bloc/follow_user_bloc/follow_user_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_followers_bloc/user_followers_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_followings_bloc/user_followings_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_saved_posts_pagination_bloc/user_saved_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/unfollow_user_bloc/unfollow_user_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:snibbo_app/presentation/general/presentation/bloc/hide_bottom_nav_bloc/hide_bottom_nav_bloc.dart';
import 'package:snibbo_app/presentation/routes/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/service_locator.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final brightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  setupServiceLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(initialBrightness: brightness),
        ),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<RegisterBloc>(create: (context) => RegisterBloc()),
        BlocProvider<ForgetPassBloc>(create: (context) => ForgetPassBloc()),
        BlocProvider<GetFeedBloc>(create: (context) => GetFeedBloc()),
        BlocProvider<CreateStoryBloc>(create: (context) => CreateStoryBloc()),
        BlocProvider<GetUserStoriesBloc>(
          create: (context) => GetUserStoriesBloc(),
        ),
        BlocProvider<StoryViewersBloc>(create: (context) => StoryViewersBloc()),
        BlocProvider<DeleteStoryBloc>(create: (context) => DeleteStoryBloc()),
        BlocProvider<ViewStoryBloc>(create: (context) => ViewStoryBloc()),
        BlocProvider<StoryPaginationBloc>(
          create: (context) => StoryPaginationBloc(),
        ),
        BlocProvider<PostPaginationBloc>(
          create: (context) => PostPaginationBloc(),
        ),
        BlocProvider<CreatePostBloc>(create: (context) => CreatePostBloc()),
        BlocProvider<AnimatedLikeBloc>(create: (context) => AnimatedLikeBloc()),
        BlocProvider<UserProfileBloc>(create: (context) => UserProfileBloc()),
        BlocProvider<UpdateProfileBloc>(
          create: (context) => UpdateProfileBloc(),
        ),
        BlocProvider<LikePostBloc>(create: (context) => LikePostBloc()),
        BlocProvider<DislikePostBloc>(create: (context) => DislikePostBloc()),
        BlocProvider<UserPostsPaginationBloc>(
          create: (context) => UserPostsPaginationBloc(),
        ),
        BlocProvider<UserSavedPostsPaginationBloc>(
          create: (context) => UserSavedPostsPaginationBloc(),
        ),
        BlocProvider<SavePostAnimationBloc>(
          create: (context) => SavePostAnimationBloc(),
        ),
        BlocProvider<SavePostBloc>(create: (context) => SavePostBloc()),
        BlocProvider<RemoveSavedPostBloc>(
          create: (context) => RemoveSavedPostBloc(),
        ),
        BlocProvider<ExplorePostsBloc>(create: (context) => ExplorePostsBloc()),
        BlocProvider<GetPostCommentsBloc>(
          create: (context) => GetPostCommentsBloc(),
        ),
        BlocProvider<GetCommentRepliesBloc>(
          create: (context) => GetCommentRepliesBloc(),
        ),
        BlocProvider<ToggleCommentLikeBloc>(
          create: (context) => ToggleCommentLikeBloc(),
        ),
        BlocProvider<ToggleReplyLikeBloc>(
          create: (context) => ToggleReplyLikeBloc(),
        ),
        BlocProvider<DeleteCommentBloc>(
          create: (context) => DeleteCommentBloc(),
        ),
        BlocProvider<DeleteReplyBloc>(create: (context) => DeleteReplyBloc()),
        BlocProvider<HideBottomNavBloc>(
          create: (context) => HideBottomNavBloc(),
        ),
        BlocProvider<CreateCommentBloc>(
          create: (context) => CreateCommentBloc(),
        ),
        BlocProvider<CreateReplyBloc>(create: (context) => CreateReplyBloc()),
        BlocProvider<InputFieldBloc>(create: (context) => InputFieldBloc()),
        BlocProvider<FollowUserBloc>(create: (context) => FollowUserBloc()),
        BlocProvider<UnfollowUserBloc>(create: (context) => UnfollowUserBloc()),
        BlocProvider<UserFollowersBloc>(
          create: (context) => UserFollowersBloc(),
        ),
        BlocProvider<UserFollowingsBloc>(
          create: (context) => UserFollowingsBloc(),
        ),
        BlocProvider<PostLikedUsersBloc>(
          create: (context) => PostLikedUsersBloc(),
        ),
        BlocProvider<CommentLikedUsersBloc>(
          create: (context) => CommentLikedUsersBloc(),
        ),
        BlocProvider<ReplyLikedUsersBloc>(
          create: (context) => ReplyLikedUsersBloc(),
        ),
        BlocProvider<SearchUserBloc>(
          create: (context) => SearchUserBloc(),
        ),
        BlocProvider<UpdatePostBloc>(
          create: (context) => UpdatePostBloc(),
        ),
        BlocProvider<DeletePostBloc>(
          create: (context) => DeletePostBloc(),
        ),
      ],

      child: ToastificationWrapper(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: ScreenUtilInit(
        designSize: Size(412, 915),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return BlocBuilder<ThemeBloc, ThemeStates>(
            builder: (context, state) {
              ThemeMode themeMode;
              if (state is DarkThemeState) {
                themeMode = ThemeMode.dark;
              } else {
                themeMode = ThemeMode.light;
              }
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: _appRouter.config(),
                title: 'Snibbo',
                themeMode: themeMode,
                theme: Themedata.lightTheme(context),
                darkTheme: Themedata.darkTheme(context),
              );
            },
          );
        },
      ),
    );
  }
}
