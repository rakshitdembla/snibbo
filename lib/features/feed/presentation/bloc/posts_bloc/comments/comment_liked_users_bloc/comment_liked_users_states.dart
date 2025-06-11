import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';

abstract class CommentLikedUsersStates extends Equatable {
  const CommentLikedUsersStates();

  @override
  List<Object?> get props => [];
}

class CommentLikedUsersInitial extends CommentLikedUsersStates {}

class CommentLikedUsersLoading extends CommentLikedUsersStates {
  final String commentId;

  const CommentLikedUsersLoading({required this.commentId});

  @override
  List<Object?> get props => [commentId];
}

class CommentLikedUsersLoaded extends CommentLikedUsersStates {
  final List<UserEntity> users;
  final String commentId;

  const CommentLikedUsersLoaded({required this.users, required this.commentId});

  @override
  List<Object?> get props => [users, commentId];
}

class CommentLikedUsersPaginationSuccess extends CommentLikedUsersStates {
  final List<UserEntity> users;
  final String commentId;

  const CommentLikedUsersPaginationSuccess({
    required this.users,
    required this.commentId,
  });

  @override
  List<Object?> get props => [users, commentId];
}

class CommentLikedUsersError extends CommentLikedUsersStates {
  final String title;
  final String descrition;
  final String commentId;

  const CommentLikedUsersError({
    required this.title,
    required this.descrition,
    required this.commentId,
  });

  @override
  List<Object?> get props => [title, descrition, commentId];
}

class CommentLikedUsersPaginationError extends CommentLikedUsersStates {
  final String title;
  final String descrition;
  final String commentId;

  const CommentLikedUsersPaginationError({
    required this.title,
    required this.descrition,
    required this.commentId,
  });

  @override
  List<Object?> get props => [title, descrition, commentId];
}
