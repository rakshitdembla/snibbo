import 'package:equatable/equatable.dart';

abstract class FollowUserStates extends Equatable {
  @override
  List<Object> get props => [];
}

class FollowUserInitial extends FollowUserStates {}

class FollowUserLoading extends FollowUserStates {}

class FollowUserSuccess extends FollowUserStates {
  final String title;
  final String description;

  FollowUserSuccess({required this.description, required this.title});
}

class FollowUserError extends FollowUserStates {
  final String title;
  final String description;

  FollowUserError({required this.description, required this.title});

  @override
  List<Object> get props => [title, description];
}
