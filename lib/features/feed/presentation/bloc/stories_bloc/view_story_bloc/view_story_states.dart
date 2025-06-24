import 'package:equatable/equatable.dart';

abstract class ViewStoryStates extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewStoryInitialState extends ViewStoryStates {}

class ViewStoryLoadingState extends ViewStoryStates {}

class ViewStoryErrorState extends ViewStoryStates {
  final String title;
  final String description;

  ViewStoryErrorState({required this.description, required this.title});
}

class ViewStorySuccessState extends ViewStoryStates {
  final String title;
  final String description;

  ViewStorySuccessState({required this.title, required this.description});
}

class AllStoriesSeenState extends ViewStoryStates {
  final String username;
  AllStoriesSeenState({required this.username});
  @override
  List<Object> get props => [username];
}
