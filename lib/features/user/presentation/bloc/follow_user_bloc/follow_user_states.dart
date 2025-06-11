import 'package:equatable/equatable.dart';

abstract class FollowUserStates extends Equatable {
  @override
  List<Object> get props => [];
}

class FollowUserInitial extends FollowUserStates {}

class FollowUserLoading extends FollowUserStates {
  final String username;

  FollowUserLoading({required this.username});

  @override
  List<Object> get props => [username];
}

class FollowUserSuccess extends FollowUserStates {
  final String title;
  final String description;
  final String username;

  FollowUserSuccess({required this.description, required this.title,required this.username});

    @override
  List<Object> get props => [username,description,title];
}

class FollowUserError extends FollowUserStates {
  final String title;
  final String description;
  final String username;

  FollowUserError({required this.description, required this.title,required this.username});

  @override
  List<Object> get props => [title, description,username];
}
