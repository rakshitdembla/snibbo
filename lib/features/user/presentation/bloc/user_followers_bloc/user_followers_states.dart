import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';

abstract class UserFollowersStates extends Equatable {
  const UserFollowersStates();

  @override
  List<Object?> get props => [];
}

class UserFollowersInitial extends UserFollowersStates {}

class UserFollowersLoading extends UserFollowersStates {
  final String username;

  const UserFollowersLoading({required this.username});

  @override
  List<Object?> get props => [username];
}

class UserFollowersLoaded extends UserFollowersStates {
  final List<UserEntity> users;
  final String username;

  const UserFollowersLoaded({required this.users, required this.username});

  @override
  List<Object?> get props => [users, username];
}

class UserFollowersPaginationSuccess extends UserFollowersStates {
  final List<UserEntity> users;
  final String username;

  const UserFollowersPaginationSuccess({
    required this.users,
    required this.username,
  });

  @override
  List<Object?> get props => [users, username];
}

class UserFollowersError extends UserFollowersStates {
  final String title;
  final String descrition;
  final String username;

  const UserFollowersError({
    required this.title,
    required this.descrition,
    required this.username,
  });

  @override
  List<Object?> get props => [title, descrition, username];
}

class UserFollowersPaginationError extends UserFollowersStates {
  final String title;
  final String descrition;
  final String username;

  const UserFollowersPaginationError({
    required this.title,
    required this.descrition,
    required this.username,
  });

  @override
  List<Object?> get props => [title, descrition, username];
}

