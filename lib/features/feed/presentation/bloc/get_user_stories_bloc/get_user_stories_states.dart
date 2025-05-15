import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';

abstract class UserStoriesStates extends Equatable {
  @override
  List<Object> get props => [];
}

class UserStoriesInitialState extends UserStoriesStates {}

class UserStoriesLoadingState extends UserStoriesStates {}

class UserStoriesErrorState extends UserStoriesStates {
  final String title;
  final String description;

  UserStoriesErrorState({required this.description, required this.title});
}

class UserStoriesSuccessState extends UserStoriesStates {
final UserStoriesEntity userStories;

  UserStoriesSuccessState({
  required this.userStories
  });

  @override
  List<Object> get props => [userStories];
}
