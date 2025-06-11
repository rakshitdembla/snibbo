import 'package:equatable/equatable.dart';

abstract class UnfollowUserStates extends Equatable {
  @override
  List<Object> get props => [];
}

class UnfollowUserInitial extends UnfollowUserStates {}

class UnfollowUserLoading extends UnfollowUserStates {
  final String username;

  UnfollowUserLoading({required this.username});
  @override
  List<Object> get props => [username];

}

class UnfollowUserSuccess extends UnfollowUserStates {
  final String title;
  final String description;
  final String username;

  UnfollowUserSuccess({required this.description, required this.title,required this.username});


  @override
  List<Object> get props => [title, description,username];
}

class UnfollowUserError extends UnfollowUserStates {
  final String title;
  final String description;
  final String username;

  UnfollowUserError({required this.description, required this.title,required this.username});

  @override
  List<Object> get props => [title, description,username];
}
