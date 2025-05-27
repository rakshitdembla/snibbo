import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';

abstract class UserStoriesStates extends Equatable {
  @override
  List<Object> get props => [];
}

class UserStoriesInitialState extends UserStoriesStates {}

class UserStoriesLoadingState extends UserStoriesStates {
  final String username;

  UserStoriesLoadingState({required this.username});
}

class UserStoriesErrorState extends UserStoriesStates {
  final String title;
  final String description;
  final String username;

  UserStoriesErrorState({
    required this.description,
    required this.title,
    required this.username,
  });
}

class UserStoriesSuccessState extends UserStoriesStates {
  final UserStoriesEntity userStories;
  final String username;

  UserStoriesSuccessState({required this.userStories, required this.username});

  @override
  List<Object> get props => [userStories];
}
