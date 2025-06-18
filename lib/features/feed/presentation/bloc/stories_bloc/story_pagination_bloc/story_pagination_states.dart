import 'package:snibbo_app/core/entities/user_entity.dart';

abstract class StoryPaginationStates {}

class StoryPaginationInitial extends StoryPaginationStates {}

class StoryPaginationLoading extends StoryPaginationStates {}

class StoryPaginationLoaded extends StoryPaginationStates {
  final List<UserEntity> storiesList;
  final bool hasMore;

  StoryPaginationLoaded({required this.storiesList, required this.hasMore});
}

class StoryPaginationError extends StoryPaginationStates {
  final String title;
  final String description;
  StoryPaginationError({required this.title, required this.description});
}
