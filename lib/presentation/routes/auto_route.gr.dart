// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i25;
import 'package:flutter/cupertino.dart' as _i29;
import 'package:flutter/material.dart' as _i26;
import 'package:snibbo_app/features/auth/presentation/pages/forget_password_screen.dart'
    as _i7;
import 'package:snibbo_app/features/auth/presentation/pages/login_screen.dart'
    as _i9;
import 'package:snibbo_app/features/auth/presentation/pages/register_screen.dart'
    as _i15;
import 'package:snibbo_app/features/chats/presentation/pages/chat_list_screen.dart'
    as _i1;
import 'package:snibbo_app/features/chats/presentation/pages/chat_screen.dart'
    as _i2;
import 'package:snibbo_app/features/explore/presentation/pages/explore_posts_view_screen.dart'
    as _i4;
import 'package:snibbo_app/features/explore/presentation/pages/explore_screen.dart'
    as _i5;
import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart'
    as _i32;
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart'
    as _i27;
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart'
    as _i30;
import 'package:snibbo_app/core/entities/user_entity.dart'
    as _i28;
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart'
    as _i33;
import 'package:snibbo_app/features/feed/presentation/helpers/fetch_stories_slide_loading.dart'
    as _i6;
import 'package:snibbo_app/features/feed/presentation/helpers/story_view_slide_route.dart'
    as _i21;
import 'package:snibbo_app/features/feed/presentation/pages/comment_liked_users_screen.dart';
import 'package:snibbo_app/features/feed/presentation/pages/fetch_stories_loading.dart';
import 'package:snibbo_app/features/feed/presentation/pages/post_liked_users_screen.dart'
    as _i11;
import 'package:snibbo_app/features/feed/presentation/pages/reply_liked_users_screen.dart';
import 'package:snibbo_app/features/feed/presentation/pages/story_view_screen.dart'
    as _i20;
import 'package:snibbo_app/features/feed/presentation/pages/update_post_screen.dart'
    as _i22;
import 'package:snibbo_app/features/profile/presentation/pages/edit_profile_screen.dart'
    as _i3;
import 'package:snibbo_app/features/profile/presentation/pages/profile_screen.dart'
    as _i13;
import 'package:snibbo_app/features/settings/presentation/pages/settings_page.dart'
    as _i18;
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart'
    as _i31;
import 'package:snibbo_app/features/user/presentation/pages/saved_posts_view_screen.dart'
    as _i16;
import 'package:snibbo_app/features/user/presentation/pages/search_user_screen.dart'
    as _i17;
import 'package:snibbo_app/features/user/presentation/pages/user_connections_screen.dart';
import 'package:snibbo_app/features/user/presentation/pages/user_posts_view_screen.dart'
    as _i23;
import 'package:snibbo_app/features/user/presentation/pages/user_profile_screen.dart'
    as _i24;
import 'package:snibbo_app/features/user/presentation/widgets/profile_view.dart'
    as _i14;
import 'package:snibbo_app/presentation/general/presentation/pages/general_page.dart'
    as _i8;
import 'package:snibbo_app/presentation/onboard/presentation/pages/onboard_screen.dart'
    as _i10;
import 'package:snibbo_app/presentation/posts_view/presentation/pages/posts_view_screen.dart'
    as _i12;
import 'package:snibbo_app/presentation/splash/presentation/pages/splash_screen.dart'
    as _i19;

/// generated route for
/// [_i1.ChatListScreen]
class ChatListScreenRoute extends _i25.PageRouteInfo<void> {
  const ChatListScreenRoute({List<_i25.PageRouteInfo>? children})
    : super(ChatListScreenRoute.name, initialChildren: children);

  static const String name = 'ChatListScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i1.ChatListScreen();
    },
  );
}

/// generated route for
/// [_i2.ChatScreen]
class ChatScreenRoute extends _i25.PageRouteInfo<void> {
  const ChatScreenRoute({List<_i25.PageRouteInfo>? children})
    : super(ChatScreenRoute.name, initialChildren: children);

  static const String name = 'ChatScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i2.ChatScreen();
    },
  );
}

/// generated route for
/// [CommentLikedUsersScreen]
class CommentLikedUsersScreenRoute
    extends _i25.PageRouteInfo<CommentLikedUsersScreenRouteArgs> {
  CommentLikedUsersScreenRoute({
    _i26.Key? key,
    required _i27.PostCommentEntity comment,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         CommentLikedUsersScreenRoute.name,
         args: CommentLikedUsersScreenRouteArgs(key: key, comment: comment),
         initialChildren: children,
       );

  static const String name = 'CommentLikedUsersScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CommentLikedUsersScreenRouteArgs>();
      return CommentLikedUsersScreen(key: args.key, comment: args.comment);
    },
  );
}

class CommentLikedUsersScreenRouteArgs {
  const CommentLikedUsersScreenRouteArgs({this.key, required this.comment});

  final _i26.Key? key;

  final _i27.PostCommentEntity comment;

  @override
  String toString() {
    return 'CommentLikedUsersScreenRouteArgs{key: $key, comment: $comment}';
  }
}

/// generated route for
/// [_i3.EditProfileScreen]
class EditProfileScreenRoute
    extends _i25.PageRouteInfo<EditProfileScreenRouteArgs> {
  EditProfileScreenRoute({
    _i26.Key? key,
    required String bio,
    required String name,
    required String profileUrl,
    required String username,
    List<_i25.PageRouteInfo>? children,
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

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileScreenRouteArgs>();
      return _i3.EditProfileScreen(
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

  final _i26.Key? key;

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
/// [_i4.ExplorePostsViewScreen]
class ExplorePostsViewScreenRoute
    extends _i25.PageRouteInfo<ExplorePostsViewScreenRouteArgs> {
  ExplorePostsViewScreenRoute({
    _i26.Key? key,
    required int initialIndex,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         ExplorePostsViewScreenRoute.name,
         args: ExplorePostsViewScreenRouteArgs(
           key: key,
           initialIndex: initialIndex,
         ),
         initialChildren: children,
       );

  static const String name = 'ExplorePostsViewScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExplorePostsViewScreenRouteArgs>();
      return _i4.ExplorePostsViewScreen(
        key: args.key,
        initialIndex: args.initialIndex,
      );
    },
  );
}

class ExplorePostsViewScreenRouteArgs {
  const ExplorePostsViewScreenRouteArgs({this.key, required this.initialIndex});

  final _i26.Key? key;

  final int initialIndex;

  @override
  String toString() {
    return 'ExplorePostsViewScreenRouteArgs{key: $key, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i5.ExploreScreen]
class ExploreScreenRoute extends _i25.PageRouteInfo<void> {
  const ExploreScreenRoute({List<_i25.PageRouteInfo>? children})
    : super(ExploreScreenRoute.name, initialChildren: children);

  static const String name = 'ExploreScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i5.ExploreScreen();
    },
  );
}

/// generated route for
/// [FetchStoriesLoading]
class FetchStoriesLoadingRoute
    extends _i25.PageRouteInfo<FetchStoriesLoadingRouteArgs> {
  FetchStoriesLoadingRoute({
    _i26.Key? key,
    required String username,
    required bool isPreviousSlide,
    required String profilePicture,
    List<_i28.UserEntity>? storyUsers,
    List<_i25.PageRouteInfo>? children,
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

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FetchStoriesLoadingRouteArgs>();
      return FetchStoriesLoading(
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

  final _i26.Key? key;

  final String username;

  final bool isPreviousSlide;

  final String profilePicture;

  final List<_i28.UserEntity>? storyUsers;

  @override
  String toString() {
    return 'FetchStoriesLoadingRouteArgs{key: $key, username: $username, isPreviousSlide: $isPreviousSlide, profilePicture: $profilePicture, storyUsers: $storyUsers}';
  }
}

/// generated route for
/// [_i6.FetchStoriesLoadingSlidePage]
class FetchStoriesLoadingSlidePageRoute
    extends _i25.PageRouteInfo<FetchStoriesLoadingSlidePageRouteArgs> {
  FetchStoriesLoadingSlidePageRoute({
    _i29.Key? key,
    required _i28.UserEntity user,
    required List<_i28.UserEntity> storyUsers,
    required String profilePicture,
    List<_i25.PageRouteInfo>? children,
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

  static _i25.PageInfo page = _i25.PageInfo(
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

  final _i29.Key? key;

  final _i28.UserEntity user;

  final List<_i28.UserEntity> storyUsers;

  final String profilePicture;

  @override
  String toString() {
    return 'FetchStoriesLoadingSlidePageRouteArgs{key: $key, user: $user, storyUsers: $storyUsers, profilePicture: $profilePicture}';
  }
}

/// generated route for
/// [_i7.ForgotPasswordScreen]
class ForgotPasswordScreenRoute extends _i25.PageRouteInfo<void> {
  const ForgotPasswordScreenRoute({List<_i25.PageRouteInfo>? children})
    : super(ForgotPasswordScreenRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i7.ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [_i8.GeneralPage]
class GeneralPageRoute extends _i25.PageRouteInfo<void> {
  const GeneralPageRoute({List<_i25.PageRouteInfo>? children})
    : super(GeneralPageRoute.name, initialChildren: children);

  static const String name = 'GeneralPageRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i8.GeneralPage();
    },
  );
}

/// generated route for
/// [_i9.LoginScreen]
class LoginScreenRoute extends _i25.PageRouteInfo<LoginScreenRouteArgs> {
  LoginScreenRoute({
    _i26.Key? key,
    required bool routedFromRegister,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         LoginScreenRoute.name,
         args: LoginScreenRouteArgs(
           key: key,
           routedFromRegister: routedFromRegister,
         ),
         initialChildren: children,
       );

  static const String name = 'LoginScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginScreenRouteArgs>();
      return _i9.LoginScreen(
        key: args.key,
        routedFromRegister: args.routedFromRegister,
      );
    },
  );
}

class LoginScreenRouteArgs {
  const LoginScreenRouteArgs({this.key, required this.routedFromRegister});

  final _i26.Key? key;

  final bool routedFromRegister;

  @override
  String toString() {
    return 'LoginScreenRouteArgs{key: $key, routedFromRegister: $routedFromRegister}';
  }
}

/// generated route for
/// [_i10.OnboardScreen]
class OnboardScreenRoute extends _i25.PageRouteInfo<void> {
  const OnboardScreenRoute({List<_i25.PageRouteInfo>? children})
    : super(OnboardScreenRoute.name, initialChildren: children);

  static const String name = 'OnboardScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i10.OnboardScreen();
    },
  );
}

/// generated route for
/// [_i11.PostLikedUsersScreen]
class PostLikedUsersScreenRoute
    extends _i25.PageRouteInfo<PostLikedUsersScreenRouteArgs> {
  PostLikedUsersScreenRoute({
    _i26.Key? key,
    required _i30.PostEntity post,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         PostLikedUsersScreenRoute.name,
         args: PostLikedUsersScreenRouteArgs(key: key, post: post),
         initialChildren: children,
       );

  static const String name = 'PostLikedUsersScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostLikedUsersScreenRouteArgs>();
      return _i11.PostLikedUsersScreen(key: args.key, post: args.post);
    },
  );
}

class PostLikedUsersScreenRouteArgs {
  const PostLikedUsersScreenRouteArgs({this.key, required this.post});

  final _i26.Key? key;

  final _i30.PostEntity post;

  @override
  String toString() {
    return 'PostLikedUsersScreenRouteArgs{key: $key, post: $post}';
  }
}

/// generated route for
/// [_i12.PostsViewScreen]
class PostsViewScreenRoute
    extends _i25.PageRouteInfo<PostsViewScreenRouteArgs> {
  PostsViewScreenRoute({
    _i26.Key? key,
    required String appbarTitle,
    required List<dynamic> posts,
    List<_i25.PageRouteInfo>? children,
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

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostsViewScreenRouteArgs>();
      return _i12.PostsViewScreen(
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

  final _i26.Key? key;

  final String appbarTitle;

  final List<dynamic> posts;

  @override
  String toString() {
    return 'PostsViewScreenRouteArgs{key: $key, appbarTitle: $appbarTitle, posts: $posts}';
  }
}

/// generated route for
/// [_i13.ProfileScreen]
class ProfileScreenRoute extends _i25.PageRouteInfo<ProfileScreenRouteArgs> {
  ProfileScreenRoute({
    _i26.Key? key,
    required String? onPopRefreshUsername,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         ProfileScreenRoute.name,
         args: ProfileScreenRouteArgs(
           key: key,
           onPopRefreshUsername: onPopRefreshUsername,
         ),
         initialChildren: children,
       );

  static const String name = 'ProfileScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileScreenRouteArgs>();
      return _i13.ProfileScreen(
        key: args.key,
        onPopRefreshUsername: args.onPopRefreshUsername,
      );
    },
  );
}

class ProfileScreenRouteArgs {
  const ProfileScreenRouteArgs({this.key, required this.onPopRefreshUsername});

  final _i26.Key? key;

  final String? onPopRefreshUsername;

  @override
  String toString() {
    return 'ProfileScreenRouteArgs{key: $key, onPopRefreshUsername: $onPopRefreshUsername}';
  }
}

/// generated route for
/// [_i14.ProfileView]
class ProfileViewRoute extends _i25.PageRouteInfo<ProfileViewRouteArgs> {
  ProfileViewRoute({
    _i26.Key? key,
    required _i31.ProfileEntity profileEntity,
    required String? onPopRefreshUsername,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         ProfileViewRoute.name,
         args: ProfileViewRouteArgs(
           key: key,
           profileEntity: profileEntity,
           onPopRefreshUsername: onPopRefreshUsername,
         ),
         initialChildren: children,
       );

  static const String name = 'ProfileViewRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileViewRouteArgs>();
      return _i14.ProfileView(
        key: args.key,
        profileEntity: args.profileEntity,
        onPopRefreshUsername: args.onPopRefreshUsername,
      );
    },
  );
}

class ProfileViewRouteArgs {
  const ProfileViewRouteArgs({
    this.key,
    required this.profileEntity,
    required this.onPopRefreshUsername,
  });

  final _i26.Key? key;

  final _i31.ProfileEntity profileEntity;

  final String? onPopRefreshUsername;

  @override
  String toString() {
    return 'ProfileViewRouteArgs{key: $key, profileEntity: $profileEntity, onPopRefreshUsername: $onPopRefreshUsername}';
  }
}

/// generated route for
/// [_i15.RegisterScreen]
class RegisterScreenRoute extends _i25.PageRouteInfo<RegisterScreenRouteArgs> {
  RegisterScreenRoute({
    _i26.Key? key,
    required bool routedFromLogin,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         RegisterScreenRoute.name,
         args: RegisterScreenRouteArgs(
           key: key,
           routedFromLogin: routedFromLogin,
         ),
         initialChildren: children,
       );

  static const String name = 'RegisterScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterScreenRouteArgs>();
      return _i15.RegisterScreen(
        key: args.key,
        routedFromLogin: args.routedFromLogin,
      );
    },
  );
}

class RegisterScreenRouteArgs {
  const RegisterScreenRouteArgs({this.key, required this.routedFromLogin});

  final _i26.Key? key;

  final bool routedFromLogin;

  @override
  String toString() {
    return 'RegisterScreenRouteArgs{key: $key, routedFromLogin: $routedFromLogin}';
  }
}

/// generated route for
/// [ReplyLikedUsersScreen]
class ReplyLikedUsersScreenRoute
    extends _i25.PageRouteInfo<ReplyLikedUsersScreenRouteArgs> {
  ReplyLikedUsersScreenRoute({
    _i26.Key? key,
    required _i32.CommentReplyEntity reply,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         ReplyLikedUsersScreenRoute.name,
         args: ReplyLikedUsersScreenRouteArgs(key: key, reply: reply),
         initialChildren: children,
       );

  static const String name = 'ReplyLikedUsersScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReplyLikedUsersScreenRouteArgs>();
      return ReplyLikedUsersScreen(key: args.key, reply: args.reply);
    },
  );
}

class ReplyLikedUsersScreenRouteArgs {
  const ReplyLikedUsersScreenRouteArgs({this.key, required this.reply});

  final _i26.Key? key;

  final _i32.CommentReplyEntity reply;

  @override
  String toString() {
    return 'ReplyLikedUsersScreenRouteArgs{key: $key, reply: $reply}';
  }
}

/// generated route for
/// [_i16.SavedPostsViewScreen]
class SavedPostsViewScreenRoute
    extends _i25.PageRouteInfo<SavedPostsViewScreenRouteArgs> {
  SavedPostsViewScreenRoute({
    _i26.Key? key,
    required _i31.ProfileEntity profileEntity,
    required int initialIndex,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         SavedPostsViewScreenRoute.name,
         args: SavedPostsViewScreenRouteArgs(
           key: key,
           profileEntity: profileEntity,
           initialIndex: initialIndex,
         ),
         initialChildren: children,
       );

  static const String name = 'SavedPostsViewScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SavedPostsViewScreenRouteArgs>();
      return _i16.SavedPostsViewScreen(
        key: args.key,
        profileEntity: args.profileEntity,
        initialIndex: args.initialIndex,
      );
    },
  );
}

class SavedPostsViewScreenRouteArgs {
  const SavedPostsViewScreenRouteArgs({
    this.key,
    required this.profileEntity,
    required this.initialIndex,
  });

  final _i26.Key? key;

  final _i31.ProfileEntity profileEntity;

  final int initialIndex;

  @override
  String toString() {
    return 'SavedPostsViewScreenRouteArgs{key: $key, profileEntity: $profileEntity, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i17.SearchUserScreen]
class SearchUserScreenRoute extends _i25.PageRouteInfo<void> {
  const SearchUserScreenRoute({List<_i25.PageRouteInfo>? children})
    : super(SearchUserScreenRoute.name, initialChildren: children);

  static const String name = 'SearchUserScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i17.SearchUserScreen();
    },
  );
}

/// generated route for
/// [_i18.SettingsScreen]
class SettingsScreenRoute extends _i25.PageRouteInfo<void> {
  const SettingsScreenRoute({List<_i25.PageRouteInfo>? children})
    : super(SettingsScreenRoute.name, initialChildren: children);

  static const String name = 'SettingsScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i18.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i19.SplashScreen]
class SplashScreenRoute extends _i25.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i25.PageRouteInfo>? children})
    : super(SplashScreenRoute.name, initialChildren: children);

  static const String name = 'SplashScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i19.SplashScreen();
    },
  );
}

/// generated route for
/// [_i20.StoryViewScreen]
class StoryViewScreenRoute
    extends _i25.PageRouteInfo<StoryViewScreenRouteArgs> {
  StoryViewScreenRoute({
    _i26.Key? key,
    required List<_i33.StoryEntitiy> stories,
    required String username,
    required String profilePicture,
    required bool isMyStory,
    List<_i28.UserEntity>? storyUsers,
    List<_i25.PageRouteInfo>? children,
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

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StoryViewScreenRouteArgs>();
      return _i20.StoryViewScreen(
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

  final _i26.Key? key;

  final List<_i33.StoryEntitiy> stories;

  final String username;

  final String profilePicture;

  final bool isMyStory;

  final List<_i28.UserEntity>? storyUsers;

  @override
  String toString() {
    return 'StoryViewScreenRouteArgs{key: $key, stories: $stories, username: $username, profilePicture: $profilePicture, isMyStory: $isMyStory, storyUsers: $storyUsers}';
  }
}

/// generated route for
/// [_i21.StoryViewSlidePage]
class StoryViewSlidePageRoute
    extends _i25.PageRouteInfo<StoryViewSlidePageRouteArgs> {
  StoryViewSlidePageRoute({
    _i29.Key? key,
    required List<_i33.StoryEntitiy> stories,
    required String username,
    required String profilePicture,
    required bool isMyStory,
    List<_i28.UserEntity>? storyUsers,
    List<_i25.PageRouteInfo>? children,
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

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StoryViewSlidePageRouteArgs>();
      return _i21.StoryViewSlidePage(
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

  final _i29.Key? key;

  final List<_i33.StoryEntitiy> stories;

  final String username;

  final String profilePicture;

  final bool isMyStory;

  final List<_i28.UserEntity>? storyUsers;

  @override
  String toString() {
    return 'StoryViewSlidePageRouteArgs{key: $key, stories: $stories, username: $username, profilePicture: $profilePicture, isMyStory: $isMyStory, storyUsers: $storyUsers}';
  }
}

/// generated route for
/// [_i22.UpdatePostScreen]
class UpdatePostScreenRoute
    extends _i25.PageRouteInfo<UpdatePostScreenRouteArgs> {
  UpdatePostScreenRoute({
    _i26.Key? key,
    required String postId,
    required String imageUrl,
    required String initialCaption,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         UpdatePostScreenRoute.name,
         args: UpdatePostScreenRouteArgs(
           key: key,
           postId: postId,
           imageUrl: imageUrl,
           initialCaption: initialCaption,
         ),
         initialChildren: children,
       );

  static const String name = 'UpdatePostScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UpdatePostScreenRouteArgs>();
      return _i22.UpdatePostScreen(
        key: args.key,
        postId: args.postId,
        imageUrl: args.imageUrl,
        initialCaption: args.initialCaption,
      );
    },
  );
}

class UpdatePostScreenRouteArgs {
  const UpdatePostScreenRouteArgs({
    this.key,
    required this.postId,
    required this.imageUrl,
    required this.initialCaption,
  });

  final _i26.Key? key;

  final String postId;

  final String imageUrl;

  final String initialCaption;

  @override
  String toString() {
    return 'UpdatePostScreenRouteArgs{key: $key, postId: $postId, imageUrl: $imageUrl, initialCaption: $initialCaption}';
  }
}

/// generated route for
/// [UserConnectionsScreen]
class UserConnectionsScreenRoute
    extends _i25.PageRouteInfo<UserConnectionsScreenRouteArgs> {
  UserConnectionsScreenRoute({
    _i26.Key? key,
    required String username,
    required int initialIndex,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         UserConnectionsScreenRoute.name,
         args: UserConnectionsScreenRouteArgs(
           key: key,
           username: username,
           initialIndex: initialIndex,
         ),
         initialChildren: children,
       );

  static const String name = 'UserConnectionsScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserConnectionsScreenRouteArgs>();
      return UserConnectionsScreen(
        key: args.key,
        username: args.username,
        initialIndex: args.initialIndex,
      );
    },
  );
}

class UserConnectionsScreenRouteArgs {
  const UserConnectionsScreenRouteArgs({
    this.key,
    required this.username,
    required this.initialIndex,
  });

  final _i26.Key? key;

  final String username;

  final int initialIndex;

  @override
  String toString() {
    return 'UserConnectionsScreenRouteArgs{key: $key, username: $username, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i23.UserPostsViewScreen]
class UserPostsViewScreenRoute
    extends _i25.PageRouteInfo<UserPostsViewScreenRouteArgs> {
  UserPostsViewScreenRoute({
    _i26.Key? key,
    required _i31.ProfileEntity profileEntity,
    required int initialIndex,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         UserPostsViewScreenRoute.name,
         args: UserPostsViewScreenRouteArgs(
           key: key,
           profileEntity: profileEntity,
           initialIndex: initialIndex,
         ),
         initialChildren: children,
       );

  static const String name = 'UserPostsViewScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserPostsViewScreenRouteArgs>();
      return _i23.UserPostsViewScreen(
        key: args.key,
        profileEntity: args.profileEntity,
        initialIndex: args.initialIndex,
      );
    },
  );
}

class UserPostsViewScreenRouteArgs {
  const UserPostsViewScreenRouteArgs({
    this.key,
    required this.profileEntity,
    required this.initialIndex,
  });

  final _i26.Key? key;

  final _i31.ProfileEntity profileEntity;

  final int initialIndex;

  @override
  String toString() {
    return 'UserPostsViewScreenRouteArgs{key: $key, profileEntity: $profileEntity, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i24.UserProfileScreen]
class UserProfileScreenRoute
    extends _i25.PageRouteInfo<UserProfileScreenRouteArgs> {
  UserProfileScreenRoute({
    _i26.Key? key,
    required String username,
    required String? onPopRefreshUsername,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         UserProfileScreenRoute.name,
         args: UserProfileScreenRouteArgs(
           key: key,
           username: username,
           onPopRefreshUsername: onPopRefreshUsername,
         ),
         initialChildren: children,
       );

  static const String name = 'UserProfileScreenRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserProfileScreenRouteArgs>();
      return _i24.UserProfileScreen(
        key: args.key,
        username: args.username,
        onPopRefreshUsername: args.onPopRefreshUsername,
      );
    },
  );
}

class UserProfileScreenRouteArgs {
  const UserProfileScreenRouteArgs({
    this.key,
    required this.username,
    required this.onPopRefreshUsername,
  });

  final _i26.Key? key;

  final String username;

  final String? onPopRefreshUsername;

  @override
  String toString() {
    return 'UserProfileScreenRouteArgs{key: $key, username: $username, onPopRefreshUsername: $onPopRefreshUsername}';
  }
}
