// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;
import 'package:snibbo_app/features/auth/presentation/pages/forget_password_screen.dart'
    as _i4;
import 'package:snibbo_app/features/auth/presentation/pages/login_screen.dart'
    as _i6;
import 'package:snibbo_app/features/auth/presentation/pages/register_screen.dart'
    as _i10;
import 'package:snibbo_app/features/chats/presentation/pages/chats_screen.dart'
    as _i1;
import 'package:snibbo_app/features/explore/presentation/pages/explore_screen.dart'
    as _i2;
import 'package:snibbo_app/features/explore/presentation/pages/search_screen.dart'
    as _i11;
import 'package:snibbo_app/features/feed/presentation/pages/feed_screen.dart'
    as _i3;
import 'package:snibbo_app/features/feed/presentation/pages/story_view_screen.dart'
    as _i14;
import 'package:snibbo_app/features/profile/presentation/pages/profile_screen.dart'
    as _i9;
import 'package:snibbo_app/features/settings/presentation/pages/settings_page.dart'
    as _i12;
import 'package:snibbo_app/features/user/presentation/pages/user_profile_screen.dart'
    as _i15;
import 'package:snibbo_app/presentation/general/presentation/pages/general_page.dart'
    as _i5;
import 'package:snibbo_app/presentation/onboard/presentation/pages/onboard_screen.dart'
    as _i7;
import 'package:snibbo_app/presentation/posts_view/posts_view_screen.dart'
    as _i8;
import 'package:snibbo_app/presentation/splash/presentation/pages/splash_screen.dart'
    as _i13;

/// generated route for
/// [_i1.ChatsScreen]
class ChatsScreenRoute extends _i16.PageRouteInfo<void> {
  const ChatsScreenRoute({List<_i16.PageRouteInfo>? children})
    : super(ChatsScreenRoute.name, initialChildren: children);

  static const String name = 'ChatsScreenRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i1.ChatsScreen();
    },
  );
}

/// generated route for
/// [_i2.ExploreScreen]
class ExploreScreenRoute extends _i16.PageRouteInfo<void> {
  const ExploreScreenRoute({List<_i16.PageRouteInfo>? children})
    : super(ExploreScreenRoute.name, initialChildren: children);

  static const String name = 'ExploreScreenRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i2.ExploreScreen();
    },
  );
}

/// generated route for
/// [_i3.FeedScreen]
class FeedScreenRoute extends _i16.PageRouteInfo<void> {
  const FeedScreenRoute({List<_i16.PageRouteInfo>? children})
    : super(FeedScreenRoute.name, initialChildren: children);

  static const String name = 'FeedScreenRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i3.FeedScreen();
    },
  );
}

/// generated route for
/// [_i4.ForgotPasswordScreen]
class ForgotPasswordScreenRoute extends _i16.PageRouteInfo<void> {
  const ForgotPasswordScreenRoute({List<_i16.PageRouteInfo>? children})
    : super(ForgotPasswordScreenRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordScreenRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i4.ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [_i5.GeneralPage]
class GeneralPageRoute extends _i16.PageRouteInfo<void> {
  const GeneralPageRoute({List<_i16.PageRouteInfo>? children})
    : super(GeneralPageRoute.name, initialChildren: children);

  static const String name = 'GeneralPageRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i5.GeneralPage();
    },
  );
}

/// generated route for
/// [_i6.LoginScreen]
class LoginScreenRoute extends _i16.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i16.PageRouteInfo>? children})
    : super(LoginScreenRoute.name, initialChildren: children);

  static const String name = 'LoginScreenRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i6.LoginScreen();
    },
  );
}

/// generated route for
/// [_i7.OnboardScreen]
class OnboardScreenRoute extends _i16.PageRouteInfo<void> {
  const OnboardScreenRoute({List<_i16.PageRouteInfo>? children})
    : super(OnboardScreenRoute.name, initialChildren: children);

  static const String name = 'OnboardScreenRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i7.OnboardScreen();
    },
  );
}

/// generated route for
/// [_i8.PostsViewScreen]
class PostsViewScreenRoute
    extends _i16.PageRouteInfo<PostsViewScreenRouteArgs> {
  PostsViewScreenRoute({
    _i17.Key? key,
    required String appbarTitle,
    required List<dynamic> posts,
    List<_i16.PageRouteInfo>? children,
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

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostsViewScreenRouteArgs>();
      return _i8.PostsViewScreen(
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

  final _i17.Key? key;

  final String appbarTitle;

  final List<dynamic> posts;

  @override
  String toString() {
    return 'PostsViewScreenRouteArgs{key: $key, appbarTitle: $appbarTitle, posts: $posts}';
  }
}

/// generated route for
/// [_i9.ProfileScreen]
class ProfileScreenRoute extends _i16.PageRouteInfo<void> {
  const ProfileScreenRoute({List<_i16.PageRouteInfo>? children})
    : super(ProfileScreenRoute.name, initialChildren: children);

  static const String name = 'ProfileScreenRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i9.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i10.RegisterScreen]
class RegisterScreenRoute extends _i16.PageRouteInfo<void> {
  const RegisterScreenRoute({List<_i16.PageRouteInfo>? children})
    : super(RegisterScreenRoute.name, initialChildren: children);

  static const String name = 'RegisterScreenRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i10.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i11.SearchScreen]
class SearchScreenRoute extends _i16.PageRouteInfo<void> {
  const SearchScreenRoute({List<_i16.PageRouteInfo>? children})
    : super(SearchScreenRoute.name, initialChildren: children);

  static const String name = 'SearchScreenRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i11.SearchScreen();
    },
  );
}

/// generated route for
/// [_i12.SettingsScreen]
class SettingsScreenRoute extends _i16.PageRouteInfo<void> {
  const SettingsScreenRoute({List<_i16.PageRouteInfo>? children})
    : super(SettingsScreenRoute.name, initialChildren: children);

  static const String name = 'SettingsScreenRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i12.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i13.SplashScreen]
class SplashScreenRoute extends _i16.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i16.PageRouteInfo>? children})
    : super(SplashScreenRoute.name, initialChildren: children);

  static const String name = 'SplashScreenRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i13.SplashScreen();
    },
  );
}

/// generated route for
/// [_i14.StoryViewScreen]
class StoryViewScreenRoute extends _i16.PageRouteInfo<void> {
  const StoryViewScreenRoute({List<_i16.PageRouteInfo>? children})
    : super(StoryViewScreenRoute.name, initialChildren: children);

  static const String name = 'StoryViewScreenRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i14.StoryViewScreen();
    },
  );
}

/// generated route for
/// [_i15.UserProfileScreen]
class UserProfileScreenRoute extends _i16.PageRouteInfo<void> {
  const UserProfileScreenRoute({List<_i16.PageRouteInfo>? children})
    : super(UserProfileScreenRoute.name, initialChildren: children);

  static const String name = 'UserProfileScreenRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i15.UserProfileScreen();
    },
  );
}
