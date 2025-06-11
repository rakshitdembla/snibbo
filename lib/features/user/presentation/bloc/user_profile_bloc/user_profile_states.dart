import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';

abstract class UserProfileStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserProfileInitial extends UserProfileStates {}

class UserProfileLoading extends UserProfileStates {
  final String username;

  UserProfileLoading({required this.username});

  @override
  List<Object?> get props => [username];
}

class UserProfileSuccess extends UserProfileStates {
  final bool isMyProfile;
  final ProfileEntity profileEntity;
  final List<PostEntity> userPosts;
  final List<PostEntity> userSavedPosts;
  final String username;

  UserProfileSuccess({
    required this.isMyProfile,
    required this.profileEntity,
    required this.userPosts,
    required this.userSavedPosts,
    required this.username,
  });

  @override
  List<Object?> get props => [
        isMyProfile,
        profileEntity,
        userPosts,
        userSavedPosts,
        username,
      ];
}

class UserProfileError extends UserProfileStates {
  final String title;
  final String description;
  final String username;

  UserProfileError({
    required this.description,
    required this.title,
    required this.username,
  });

  @override
  List<Object?> get props => [title, description, username];
}

