import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';

abstract class StoryViewersStates {}

class StoryViewersInitialState extends StoryViewersStates {}

class StoryViewersLoadingState extends StoryViewersStates {}

class StoryViewersErrorState extends StoryViewersStates {
  final String title;
  final String description;

  StoryViewersErrorState({required this.description, required this.title});
}

class StoryViewersSuccessState extends StoryViewersStates {
  final String title;
  final String description;
  final List<UserEntity> users;

  StoryViewersSuccessState({
    required this.title,
    required this.description,
    required this.users,
  });
}
