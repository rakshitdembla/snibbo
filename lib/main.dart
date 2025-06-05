import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/themedata.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/forget_password_bloc/forget_pass_bloc.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_post_bloc/create_post_bloc.dart';
import 'package:snibbo_app/features/create/presentation/bloc/create_story_bloc/create_story_bloc.dart';
import 'package:snibbo_app/features/explore/presentation/bloc/explore_posts_bloc/explore_posts_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/animated_like_bloc/animated_like_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/dislike_post_bloc/dislike_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/like_post_bloc/like_post_bloc.dart';
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
import 'package:snibbo_app/features/user/presentation/bloc/get_user_saved_posts_pagination_bloc/user_saved_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_posts_pagination_bloc/user_posts_pagination_bloc.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_profile_bloc/user_profile_bloc.dart';
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
        BlocProvider<ExplorePostsBloc>(
          create: (context) => ExplorePostsBloc(),
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
    return ScreenUtilInit(
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
    );
  }
}
