import 'package:equatable/equatable.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';

abstract class UserFollowingsStates extends Equatable {
  const UserFollowingsStates();

  @override
  List<Object?> get props => [];
}

class UserFollowingsInitial extends UserFollowingsStates {}

class UserFollowingsLoading extends UserFollowingsStates {
  final String username;

  const UserFollowingsLoading({required this.username});

  @override
  List<Object?> get props => [username];
}

class UserFollowingsLoaded extends UserFollowingsStates {
  final List<UserEntity> users;
  final String username;

  const UserFollowingsLoaded({required this.users, required this.username});

  @override
  List<Object?> get props => [users, username];
}

class UserFollowingsPaginationSuccess extends UserFollowingsStates {
  final List<UserEntity> users;
  final String username;

  const UserFollowingsPaginationSuccess({
    required this.users,
    required this.username,
  });

  @override
  List<Object?> get props => [users, username];
}

class UserFollowingsError extends UserFollowingsStates {
  final String title;
  final String descrition;
  final String username;

  const UserFollowingsError({
    required this.title,
    required this.descrition,
    required this.username,
  });

  @override
  List<Object?> get props => [title, descrition, username];
}

class UserFollowingsPaginationError extends UserFollowingsStates {
  final String title;
  final String descrition;
  final String username;

  const UserFollowingsPaginationError({
    required this.title,
    required this.descrition,
    required this.username,
  });

  @override
  List<Object?> get props => [title, descrition, username];
}

