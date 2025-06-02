import 'package:equatable/equatable.dart';

abstract class UnfollowUserStates extends Equatable {
  @override
  List<Object> get props => [];
}

class UnfollowUserInitial extends UnfollowUserStates {}

class UnfollowUserLoading extends UnfollowUserStates {}

class UnfollowUserSuccess extends UnfollowUserStates {
  final String title;
  final String description;

  UnfollowUserSuccess({required this.description, required this.title});
}

class UnfollowUserError extends UnfollowUserStates {
  final String title;
  final String description;

  UnfollowUserError({required this.description, required this.title});

  @override
  List<Object> get props => [title, description];
}
