// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/cupertino.dart' as _i18;
import 'package:flutter/material.dart' as _i19;
import 'package:snibbo_app/features/auth/presentation/pages/forget_password_screen.dart'
    as _i5;
import 'package:snibbo_app/features/auth/presentation/pages/login_screen.dart'
    as _i7;
import 'package:snibbo_app/features/chats/presentation/pages/chats_screen.dart'
    as _i1;
import 'package:snibbo_app/features/explore/presentation/pages/explore_screen.dart'
    as _i2;
import 'package:snibbo_app/features/explore/presentation/pages/search_screen.dart'
    as _i12;
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart'
    as _i20;
import 'package:snibbo_app/features/feed/presentation/pages/feed_screen.dart'
    as _i3;
import 'package:snibbo_app/features/feed/presentation/pages/fetch_stories_loading.dart'
    as _i4;
import 'package:snibbo_app/features/feed/presentation/pages/story_view_screen.dart'
    as _i15;
import 'package:snibbo_app/features/profile/presentation/pages/profile_screen.dart'
    as _i10;
import 'package:snibbo_app/features/settings/presentation/pages/settings_page.dart'
    as _i13;
import 'package:snibbo_app/features/settings/presentation/widgets/register_screen.dart'
    as _i11;
import 'package:snibbo_app/features/user/presentation/pages/user_profile_screen.dart'
    as _i16;
import 'package:snibbo_app/presentation/general/presentation/pages/general_page.dart'
    as _i6;
import 'package:snibbo_app/presentation/onboard/presentation/pages/onboard_screen.dart'
    as _i8;
import 'package:snibbo_app/presentation/posts_view/presentation/pages/posts_view_screen.dart'
    as _i9;
import 'package:snibbo_app/presentation/splash/presentation/pages/splash_screen.dart'
    as _i14;

/// generated route for
/// [_i1.ChatsScreen]
class ChatsScreenRoute extends _i17.PageRouteInfo<void> {
  const ChatsScreenRoute({List<_i17.PageRouteInfo>? children})
    : super(ChatsScreenRoute.name, initialChildren: children);

  static const String name = 'ChatsScreenRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i1.ChatsScreen();
    },
  );
}

/// generated route for
/// [_i2.ExploreScreen]
class ExploreScreenRoute extends _i17.PageRouteInfo<void> {
  const ExploreScreenRoute({List<_i17.PageRouteInfo>? children})
    : super(ExploreScreenRoute.name, initialChildren: children);

  static const String name = 'ExploreScreenRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i2.ExploreScreen();
    },
  );
}

/// generated route for
/// [_i3.FeedScreen]
class FeedScreenRoute extends _i17.PageRouteInfo<void> {
  const FeedScreenRoute({List<_i17.PageRouteInfo>? children})
    : super(FeedScreenRoute.name, initialChildren: children);

  static const String name = 'FeedScreenRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i3.FeedScreen();
    },
  );
}

/// generated route for
/// [_i4.FetchStoriesLoading]
class FetchStoriesLoadingRoute
    extends _i17.PageRouteInfo<FetchStoriesLoadingRouteArgs> {
  FetchStoriesLoadingRoute({
    _i18.Key? key,
    required String username,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         FetchStoriesLoadingRoute.name,
         args: FetchStoriesLoadingRouteArgs(key: key, username: username),
         initialChildren: children,
       );

  static const String name = 'FetchStoriesLoadingRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FetchStoriesLoadingRouteArgs>();
      return _i4.FetchStoriesLoading(key: args.key, username: args.username);
    },
  );
}

class FetchStoriesLoadingRouteArgs {
  const FetchStoriesLoadingRouteArgs({this.key, required this.username});

  final _i18.Key? key;

  final String username;

  @override
  String toString() {
    return 'FetchStoriesLoadingRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [_i5.ForgotPasswordScreen]
class ForgotPasswordScreenRoute extends _i17.PageRouteInfo<void> {
  const ForgotPasswordScreenRoute({List<_i17.PageRouteInfo>? children})
    : super(ForgotPasswordScreenRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordScreenRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i5.ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [_i6.GeneralPage]
class GeneralPageRoute extends _i17.PageRouteInfo<void> {
  const GeneralPageRoute({List<_i17.PageRouteInfo>? children})
    : super(GeneralPageRoute.name, initialChildren: children);

  static const String name = 'GeneralPageRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i6.GeneralPage();
    },
  );
}

/// generated route for
/// [_i7.LoginScreen]
class LoginScreenRoute extends _i17.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i17.PageRouteInfo>? children})
    : super(LoginScreenRoute.name, initialChildren: children);

  static const String name = 'LoginScreenRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i7.LoginScreen();
    },
  );
}

/// generated route for
/// [_i8.OnboardScreen]
class OnboardScreenRoute extends _i17.PageRouteInfo<void> {
  const OnboardScreenRoute({List<_i17.PageRouteInfo>? children})
    : super(OnboardScreenRoute.name, initialChildren: children);

  static const String name = 'OnboardScreenRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i8.OnboardScreen();
    },
  );
}

/// generated route for
/// [_i9.PostsViewScreen]
class PostsViewScreenRoute
    extends _i17.PageRouteInfo<PostsViewScreenRouteArgs> {
  PostsViewScreenRoute({
    _i19.Key? key,
    required String appbarTitle,
    required List<dynamic> posts,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         PostsViewScreenRoute.name,
         args: PostsViewScreenRouteArgs(
           key: key,
           appbarTitle: appbarTitle,
           posts: posts,
         ),
         initialChildren: children,
       );

  static const String name = 'PostsViewScreenRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostsViewScreenRouteArgs>();
      return _i9.PostsViewScreen(
        key: args.key,
        appbarTitle: args.appbarTitle,
        posts: args.posts,
      );
    },
  );
}

class PostsViewScreenRouteArgs {
  const PostsViewScreenRouteArgs({
    this.key,
    required this.appbarTitle,
    required this.posts,
  });

  final _i19.Key? key;

  final String appbarTitle;

  final List<dynamic> posts;

  @override
  String toString() {
    return 'PostsViewScreenRouteArgs{key: $key, appbarTitle: $appbarTitle, posts: $posts}';
  }
}

/// generated route for
/// [_i10.ProfileScreen]
class ProfileScreenRoute extends _i17.PageRouteInfo<void> {
  const ProfileScreenRoute({List<_i17.PageRouteInfo>? children})
    : super(ProfileScreenRoute.name, initialChildren: children);

  static const String name = 'ProfileScreenRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i10.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i11.RegisterScreen]
class RegisterScreenRoute extends _i17.PageRouteInfo<void> {
  const RegisterScreenRoute({List<_i17.PageRouteInfo>? children})
    : super(RegisterScreenRoute.name, initialChildren: children);

  static const String name = 'RegisterScreenRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i11.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i12.SearchScreen]
class SearchScreenRoute extends _i17.PageRouteInfo<void> {
  const SearchScreenRoute({List<_i17.PageRouteInfo>? children})
    : super(SearchScreenRoute.name, initialChildren: children);

  static const String name = 'SearchScreenRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i12.SearchScreen();
    },
  );
}

/// generated route for
/// [_i13.SettingsScreen]
class SettingsScreenRoute extends _i17.PageRouteInfo<void> {
  const SettingsScreenRoute({List<_i17.PageRouteInfo>? children})
    : super(SettingsScreenRoute.name, initialChildren: children);

  static const String name = 'SettingsScreenRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i13.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i14.SplashScreen]
class SplashScreenRoute extends _i17.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i17.PageRouteInfo>? children})
    : super(SplashScreenRoute.name, initialChildren: children);

  static const String name = 'SplashScreenRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i14.SplashScreen();
    },
  );
}

/// generated route for
/// [_i15.StoryViewScreen]
class StoryViewScreenRoute
    extends _i17.PageRouteInfo<StoryViewScreenRouteArgs> {
  StoryViewScreenRoute({
    _i19.Key? key,
    required List<_i20.StoryEntitiy> stories,
    required String username,
    required String profilePicture,
    required bool isMyStory,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         StoryViewScreenRoute.name,
         args: StoryViewScreenRouteArgs(
           key: key,
           stories: stories,
           username: username,
           profilePicture: profilePicture,
           isMyStory: isMyStory,
         ),
         initialChildren: children,
       );

  static const String name = 'StoryViewScreenRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StoryViewScreenRouteArgs>();
      return _i15.StoryViewScreen(
        key: args.key,
        stories: args.stories,
        username: args.username,
        profilePicture: args.profilePicture,
        isMyStory: args.isMyStory,
      );
    },
  );
}

class StoryViewScreenRouteArgs {
  const StoryViewScreenRouteArgs({
    this.key,
    required this.stories,
    required this.username,
    required this.profilePicture,
    required this.isMyStory,
  });

  final _i19.Key? key;

  final List<_i20.StoryEntitiy> stories;

  final String username;

  final String profilePicture;

  final bool isMyStory;

  @override
  String toString() {
    return 'StoryViewScreenRouteArgs{key: $key, stories: $stories, username: $username, profilePicture: $profilePicture, isMyStory: $isMyStory}';
  }
}

/// generated route for
/// [_i16.UserProfileScreen]
class UserProfileScreenRoute extends _i17.PageRouteInfo<void> {
  const UserProfileScreenRoute({List<_i17.PageRouteInfo>? children})
    : super(UserProfileScreenRoute.name, initialChildren: children);

  static const String name = 'UserProfileScreenRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i16.UserProfileScreen();
    },
  );
}
