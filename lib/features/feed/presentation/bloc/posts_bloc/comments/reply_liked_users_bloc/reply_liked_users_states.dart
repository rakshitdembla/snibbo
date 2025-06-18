import 'package:equatable/equatable.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';

abstract class ReplyLikedUsersStates extends Equatable {
  const ReplyLikedUsersStates();

  @override
  List<Object?> get props => [];
}

class ReplyLikedUsersInitial extends ReplyLikedUsersStates {}

class ReplyLikedUsersLoading extends ReplyLikedUsersStates {
  final String replyId;

  const ReplyLikedUsersLoading({required this.replyId});

  @override
  List<Object?> get props => [replyId];
}

class ReplyLikedUsersLoaded extends ReplyLikedUsersStates {
  final List<UserEntity> users;
  final String replyId;

  const ReplyLikedUsersLoaded({required this.users, required this.replyId});

  @override
  List<Object?> get props => [users, replyId];
}

class ReplyLikedUsersPaginationSuccess extends ReplyLikedUsersStates {
  final List<UserEntity> users;
  final String replyId;

  const ReplyLikedUsersPaginationSuccess({
    required this.users,
    required this.replyId,
  });

  @override
  List<Object?> get props => [users, replyId];
}

class ReplyLikedUsersError extends ReplyLikedUsersStates {
  final String title;
  final String descrition;
  final String replyId;

  const ReplyLikedUsersError({
    required this.title,
    required this.descrition,
    required this.replyId,
  });

  @override
  List<Object?> get props => [title, descrition, replyId];
}

class ReplyLikedUsersPaginationError extends ReplyLikedUsersStates {
  final String title;
  final String descrition;
  final String replyId;

  const ReplyLikedUsersPaginationError({
    required this.title,
    required this.descrition,
    required this.replyId,
  });

  @override
  List<Object?> get props => [title, descrition, replyId];
}
