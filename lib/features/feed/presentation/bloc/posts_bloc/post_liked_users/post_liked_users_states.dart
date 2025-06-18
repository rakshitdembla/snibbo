import 'package:equatable/equatable.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';

abstract class PostLikedUsersStates extends Equatable {
  const PostLikedUsersStates();

  @override
  List<Object?> get props => [];
}

class PostLikedUsersInitial extends PostLikedUsersStates {}

class PostLikedUsersLoading extends PostLikedUsersStates {
  final String postId;

  const PostLikedUsersLoading({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class PostLikedUsersLoaded extends PostLikedUsersStates {
  final List<UserEntity> users;
  final String postId;

  const PostLikedUsersLoaded({required this.users, required this.postId});

  @override
  List<Object?> get props => [users, postId];
}

class PostLikedUsersPaginationSuccess extends PostLikedUsersStates {
  final List<UserEntity> users;
  final String postId;

  const PostLikedUsersPaginationSuccess({
    required this.users,
    required this.postId,
  });

  @override
  List<Object?> get props => [users, postId];
}

class PostLikedUsersError extends PostLikedUsersStates {
  final String title;
  final String descrition;
  final String postId;

  const PostLikedUsersError({
    required this.title,
    required this.descrition,
    required this.postId,
  });

  @override
  List<Object?> get props => [title, descrition, postId];
}

class PostLikedUsersPaginationError extends PostLikedUsersStates {
  final String title;
  final String descrition;
  final String postId;

  const PostLikedUsersPaginationError({
    required this.title,
    required this.descrition,
    required this.postId,
  });

  @override
  List<Object?> get props => [title, descrition, postId];
}
