import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';

abstract class UserProfileStates extends Equatable {
  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileStates {}

class UserProfileLoading extends UserProfileStates {}

class UserProfileSuccess extends UserProfileStates {
  final bool isMyProfile;
  final ProfileEntity profileEntity;
  final List<PostEntity> userPosts;
  final List<PostEntity> userSavedPosts;

  UserProfileSuccess({
    required this.isMyProfile,
    required this.profileEntity,
    required this.userPosts,
    required this.userSavedPosts,
  });

  @override
  List<Object> get props => [profileEntity,userPosts,userSavedPosts];
}

class UserProfileError extends UserProfileStates {
  final String title;
  final String description;

  UserProfileError({required this.description, required this.title});
}
