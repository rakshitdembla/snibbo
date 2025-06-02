// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i20;
import 'package:flutter/cupertino.dart' as _i23;
import 'package:flutter/material.dart' as _i21;
import 'package:snibbo_app/features/auth/presentation/pages/forget_password_screen.dart'
    as _i7;
import 'package:snibbo_app/features/auth/presentation/pages/login_screen.dart'
    as _i9;
import 'package:snibbo_app/features/chats/presentation/pages/chats_screen.dart'
    as _i1;
import 'package:snibbo_app/features/explore/presentation/pages/explore_screen.dart'
    as _i3;
import 'package:snibbo_app/features/explore/presentation/pages/search_screen.dart'
    as _i14;
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart'
    as _i22;
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart'
    as _i24;
import 'package:snibbo_app/features/feed/presentation/helpers/fetch_stories_slide_loading.dart'
    as _i6;
import 'package:snibbo_app/features/feed/presentation/helpers/story_view_slide_route.dart'
    as _i18;
import 'package:snibbo_app/features/feed/presentation/pages/feed_screen.dart'
    as _i4;
import 'package:snibbo_app/features/feed/presentation/pages/fetch_stories_loading.dart'
    as _i5;
import 'package:snibbo_app/features/feed/presentation/pages/story_view_screen.dart'
    as _i17;
import 'package:snibbo_app/features/profile/presentation/pages/edit_profile_screen.dart'
    as _i2;
import 'package:snibbo_app/features/profile/presentation/pages/profile_screen.dart'
    as _i12;
import 'package:snibbo_app/features/settings/presentation/pages/settings_page.dart'
    as _i15;
import 'package:snibbo_app/features/settings/presentation/widgets/register_screen.dart'
    as _i13;
import 'package:snibbo_app/features/user/presentation/pages/user_profile_screen.dart'
    as _i19;
import 'package:snibbo_app/presentation/general/presentation/pages/general_page.dart'
    as _i8;
import 'package:snibbo_app/presentation/onboard/presentation/pages/onboard_screen.dart'
    as _i10;
import 'package:snibbo_app/presentation/posts_view/presentation/pages/posts_view_screen.dart'
    as _i11;
import 'package:snibbo_app/presentation/splash/presentation/pages/splash_screen.dart'
    as _i16;

/// generated route for
/// [_i1.ChatsScreen]
class ChatsScreenRoute extends _i20.PageRouteInfo<void> {
  const ChatsScreenRoute({List<_i20.PageRouteInfo>? children})
    : super(ChatsScreenRoute.name, initialChildren: children);

  static const String name = 'ChatsScreenRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i1.ChatsScreen();
    },
  );
}

/// generated route for
/// [_i2.EditProfileScreen]
class EditProfileScreenRoute
    extends _i20.PageRouteInfo<EditProfileScreenRouteArgs> {
  EditProfileScreenRoute({
    _i21.Key? key,
    required String bio,
    required String name,
    required String profileUrl,
    required String username,
    List<_i20.PageRouteInfo>? children,
  }) : super(
         EditProfileScreenRoute.name,
         args: EditProfileScreenRouteArgs(
           key: key,
           bio: bio,
           name: name,
           profileUrl: profileUrl,
           username: username,
         ),
         initialChildren: children,
       );

  static const String name = 'EditProfileScreenRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileScreenRouteArgs>();
      return _i2.EditProfileScreen(
        key: args.key,
        bio: args.bio,
        name: args.name,
        profileUrl: args.profileUrl,
        username: args.username,
      );
    },
  );
}

class EditProfileScreenRouteArgs {
  const EditProfileScreenRouteArgs({
    this.key,
    required this.bio,
    required this.name,
    required this.profileUrl,
    required this.username,
  });

  final _i21.Key? key;

  final String bio;

  final String name;

  final String profileUrl;

  final String username;

  @override
  String toString() {
    return 'EditProfileScreenRouteArgs{key: $key, bio: $bio, name: $name, profileUrl: $profileUrl, username: $username}';
  }
}

/// generated route for
/// [_i3.ExploreScreen]
class ExploreScreenRoute extends _i20.PageRouteInfo<void> {
  const ExploreScreenRoute({List<_i20.PageRouteInfo>? children})
    : super(ExploreScreenRoute.name, initialChildren: children);

  static const String name = 'ExploreScreenRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i3.ExploreScreen();
    },
  );
}

/// generated route for
/// [_i4.FeedScreen]
class FeedScreenRoute extends _i20.PageRouteInfo<void> {
  const FeedScreenRoute({List<_i20.PageRouteInfo>? children})
    : super(FeedScreenRoute.name, initialChildren: children);

  static const String name = 'FeedScreenRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i4.FeedScreen();
    },
  );
}

/// generated route for
/// [_i5.FetchStoriesLoading]
class FetchStoriesLoadingRoute
    extends _i20.PageRouteInfo<FetchStoriesLoadingRouteArgs> {
  FetchStoriesLoadingRoute({
    _i21.Key? key,
    required String username,
    required bool isPreviousSlide,
    required String profilePicture,
    List<_i22.UserEntity>? storyUsers,
    List<_i20.PageRouteInfo>? children,
  }) : super(
         FetchStoriesLoadingRoute.name,
         args: FetchStoriesLoadingRouteArgs(
           key: key,
           username: username,
           isPreviousSlide: isPreviousSlide,
           profilePicture: profilePicture,
           storyUsers: storyUsers,
         ),
         initialChildren: children,
       );

  static const String name = 'FetchStoriesLoadingRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FetchStoriesLoadingRouteArgs>();
      return _i5.FetchStoriesLoading(
        key: args.key,
        username: args.username,
        isPreviousSlide: args.isPreviousSlide,
        profilePicture: args.profilePicture,
        storyUsers: args.storyUsers,
      );
    },
  );
}

class FetchStoriesLoadingRouteArgs {
  const FetchStoriesLoadingRouteArgs({
    this.key,
    required this.username,
    required this.isPreviousSlide,
    required this.profilePicture,
    this.storyUsers,
  });

  final _i21.Key? key;

  final String username;

  final bool isPreviousSlide;

  final String profilePicture;

  final List<_i22.UserEntity>? storyUsers;

  @override
  String toString() {
    return 'FetchStoriesLoadingRouteArgs{key: $key, username: $username, isPreviousSlide: $isPreviousSlide, profilePicture: $profilePicture, storyUsers: $storyUsers}';
  }
}

/// generated route for
/// [_i6.FetchStoriesLoadingSlidePage]
class FetchStoriesLoadingSlidePageRoute
    extends _i20.PageRouteInfo<FetchStoriesLoadingSlidePageRouteArgs> {
  FetchStoriesLoadingSlidePageRoute({
    _i23.Key? key,
    required _i22.UserEntity user,
    required List<_i22.UserEntity> storyUsers,
    required String profilePicture,
    List<_i20.PageRouteInfo>? children,
  }) : super(
         FetchStoriesLoadingSlidePageRoute.name,
         args: FetchStoriesLoadingSlidePageRouteArgs(
           key: key,
           user: user,
           storyUsers: storyUsers,
           profilePicture: profilePicture,
         ),
         initialChildren: children,
       );

  static const String name = 'FetchStoriesLoadingSlidePageRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FetchStoriesLoadingSlidePageRouteArgs>();
      return _i6.FetchStoriesLoadingSlidePage(
        key: args.key,
        user: args.user,
        storyUsers: args.storyUsers,
        profilePicture: args.profilePicture,
      );
    },
  );
}

class FetchStoriesLoadingSlidePageRouteArgs {
  const FetchStoriesLoadingSlidePageRouteArgs({
    this.key,
    required this.user,
    required this.storyUsers,
    required this.profilePicture,
  });

  final _i23.Key? key;

  final _i22.UserEntity user;

  final List<_i22.UserEntity> storyUsers;

  final String profilePicture;

  @override
  String toString() {
    return 'FetchStoriesLoadingSlidePageRouteArgs{key: $key, user: $user, storyUsers: $storyUsers, profilePicture: $profilePicture}';
  }
}

/// generated route for
/// [_i7.ForgotPasswordScreen]
class ForgotPasswordScreenRoute extends _i20.PageRouteInfo<void> {
  const ForgotPasswordScreenRoute({List<_i20.PageRouteInfo>? children})
    : super(ForgotPasswordScreenRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordScreenRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i7.ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [_i8.GeneralPage]
class GeneralPageRoute extends _i20.PageRouteInfo<void> {
  const GeneralPageRoute({List<_i20.PageRouteInfo>? children})
    : super(GeneralPageRoute.name, initialChildren: children);

  static const String name = 'GeneralPageRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i8.GeneralPage();
    },
  );
}

/// generated route for
/// [_i9.LoginScreen]
class LoginScreenRoute extends _i20.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i20.PageRouteInfo>? children})
    : super(LoginScreenRoute.name, initialChildren: children);

  static const String name = 'LoginScreenRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i9.LoginScreen();
    },
  );
}

/// generated route for
/// [_i10.OnboardScreen]
class OnboardScreenRoute extends _i20.PageRouteInfo<void> {
  const OnboardScreenRoute({List<_i20.PageRouteInfo>? children})
    : super(OnboardScreenRoute.name, initialChildren: children);

  static const String name = 'OnboardScreenRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i10.OnboardScreen();
    },
  );
}

/// generated route for
/// [_i11.PostsViewScreen]
class PostsViewScreenRoute
    extends _i20.PageRouteInfo<PostsViewScreenRouteArgs> {
  PostsViewScreenRoute({
    _i21.Key? key,
    required String appbarTitle,
    required List<dynamic> posts,
    List<_i20.PageRouteInfo>? children,
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

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostsViewScreenRouteArgs>();
      return _i11.PostsViewScreen(
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

  final _i21.Key? key;

  final String appbarTitle;

  final List<dynamic> posts;

  @override
  String toString() {
    return 'PostsViewScreenRouteArgs{key: $key, appbarTitle: $appbarTitle, posts: $posts}';
  }
}

/// generated route for
/// [_i12.ProfileScreen]
class ProfileScreenRoute extends _i20.PageRouteInfo<void> {
  const ProfileScreenRoute({List<_i20.PageRouteInfo>? children})
    : super(ProfileScreenRoute.name, initialChildren: children);

  static const String name = 'ProfileScreenRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i12.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i13.RegisterScreen]
class RegisterScreenRoute extends _i20.PageRouteInfo<void> {
  const RegisterScreenRoute({List<_i20.PageRouteInfo>? children})
    : super(RegisterScreenRoute.name, initialChildren: children);

  static const String name = 'RegisterScreenRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i13.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i14.SearchScreen]
class SearchScreenRoute extends _i20.PageRouteInfo<void> {
  const SearchScreenRoute({List<_i20.PageRouteInfo>? children})
    : super(SearchScreenRoute.name, initialChildren: children);

  static const String name = 'SearchScreenRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i14.SearchScreen();
    },
  );
}

/// generated route for
/// [_i15.SettingsScreen]
class SettingsScreenRoute extends _i20.PageRouteInfo<void> {
  const SettingsScreenRoute({List<_i20.PageRouteInfo>? children})
    : super(SettingsScreenRoute.name, initialChildren: children);

  static const String name = 'SettingsScreenRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i15.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i16.SplashScreen]
class SplashScreenRoute extends _i20.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i20.PageRouteInfo>? children})
    : super(SplashScreenRoute.name, initialChildren: children);

  static const String name = 'SplashScreenRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i16.SplashScreen();
    },
  );
}

/// generated route for
/// [_i17.StoryViewScreen]
class StoryViewScreenRoute
    extends _i20.PageRouteInfo<StoryViewScreenRouteArgs> {
  StoryViewScreenRoute({
    _i21.Key? key,
    required List<_i24.StoryEntitiy> stories,
    required String username,
    required String profilePicture,
    required bool isMyStory,
    List<_i22.UserEntity>? storyUsers,
    List<_i20.PageRouteInfo>? children,
  }) : super(
         StoryViewScreenRoute.name,
         args: StoryViewScreenRouteArgs(
           key: key,
           stories: stories,
           username: username,
           profilePicture: profilePicture,
           isMyStory: isMyStory,
           storyUsers: storyUsers,
         ),
         initialChildren: children,
       );

  static const String name = 'StoryViewScreenRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StoryViewScreenRouteArgs>();
      return _i17.StoryViewScreen(
        key: args.key,
        stories: args.stories,
        username: args.username,
        profilePicture: args.profilePicture,
        isMyStory: args.isMyStory,
        storyUsers: args.storyUsers,
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
    this.storyUsers,
  });

  final _i21.Key? key;

  final List<_i24.StoryEntitiy> stories;

  final String username;

  final String profilePicture;

  final bool isMyStory;

  final List<_i22.UserEntity>? storyUsers;

  @override
  String toString() {
    return 'StoryViewScreenRouteArgs{key: $key, stories: $stories, username: $username, profilePicture: $profilePicture, isMyStory: $isMyStory, storyUsers: $storyUsers}';
  }
}

/// generated route for
/// [_i18.StoryViewSlidePage]
class StoryViewSlidePageRoute
    extends _i20.PageRouteInfo<StoryViewSlidePageRouteArgs> {
  StoryViewSlidePageRoute({
    _i23.Key? key,
    required List<_i24.StoryEntitiy> stories,
    required String username,
    required String profilePicture,
    required bool isMyStory,
    List<_i22.UserEntity>? storyUsers,
    List<_i20.PageRouteInfo>? children,
  }) : super(
         StoryViewSlidePageRoute.name,
         args: StoryViewSlidePageRouteArgs(
           key: key,
           stories: stories,
           username: username,
           profilePicture: profilePicture,
           isMyStory: isMyStory,
           storyUsers: storyUsers,
         ),
         initialChildren: children,
       );

  static const String name = 'StoryViewSlidePageRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StoryViewSlidePageRouteArgs>();
      return _i18.StoryViewSlidePage(
        key: args.key,
        stories: args.stories,
        username: args.username,
        profilePicture: args.profilePicture,
        isMyStory: args.isMyStory,
        storyUsers: args.storyUsers,
      );
    },
  );
}

class StoryViewSlidePageRouteArgs {
  const StoryViewSlidePageRouteArgs({
    this.key,
    required this.stories,
    required this.username,
    required this.profilePicture,
    required this.isMyStory,
    this.storyUsers,
  });

  final _i23.Key? key;

  final List<_i24.StoryEntitiy> stories;

  final String username;

  final String profilePicture;

  final bool isMyStory;

  final List<_i22.UserEntity>? storyUsers;

  @override
  String toString() {
    return 'StoryViewSlidePageRouteArgs{key: $key, stories: $stories, username: $username, profilePicture: $profilePicture, isMyStory: $isMyStory, storyUsers: $storyUsers}';
  }
}

/// generated route for
/// [_i19.UserProfileScreen]
class UserProfileScreenRoute
    extends _i20.PageRouteInfo<UserProfileScreenRouteArgs> {
  UserProfileScreenRoute({
    _i21.Key? key,
    required String profileUrl,
    required bool isStoryViewed,
    required bool showStoryBorder,
    required String name,
    required String bio,
    required int followers,
    required int followings,
    required int posts,
    required bool isMyProfile,
    required String username,
    List<_i20.PageRouteInfo>? children,
  }) : super(
         UserProfileScreenRoute.name,
         args: UserProfileScreenRouteArgs(
           key: key,
           profileUrl: profileUrl,
           isStoryViewed: isStoryViewed,
           showStoryBorder: showStoryBorder,
           name: name,
           bio: bio,
           followers: followers,
           followings: followings,
           posts: posts,
           isMyProfile: isMyProfile,
           username: username,
         ),
         initialChildren: children,
       );

  static const String name = 'UserProfileScreenRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserProfileScreenRouteArgs>();
      return _i19.UserProfileScreen(
        key: args.key,
        profileUrl: args.profileUrl,
        isStoryViewed: args.isStoryViewed,
        showStoryBorder: args.showStoryBorder,
        name: args.name,
        bio: args.bio,
        followers: args.followers,
        followings: args.followings,
        posts: args.posts,
        isMyProfile: args.isMyProfile,
        username: args.username,
      );
    },
  );
}

class UserProfileScreenRouteArgs {
  const UserProfileScreenRouteArgs({
    this.key,
    required this.profileUrl,
    required this.isStoryViewed,
    required this.showStoryBorder,
    required this.name,
    required this.bio,
    required this.followers,
    required this.followings,
    required this.posts,
    required this.isMyProfile,
    required this.username,
  });

  final _i21.Key? key;

  final String profileUrl;

  final bool isStoryViewed;

  final bool showStoryBorder;

  final String name;

  final String bio;

  final int followers;

  final int followings;

  final int posts;

  final bool isMyProfile;

  final String username;

  @override
  String toString() {
    return 'UserProfileScreenRouteArgs{key: $key, profileUrl: $profileUrl, isStoryViewed: $isStoryViewed, showStoryBorder: $showStoryBorder, name: $name, bio: $bio, followers: $followers, followings: $followings, posts: $posts, isMyProfile: $isMyProfile, username: $username}';
  }
}
