import 'package:snibbo_app/core/entities/user_entity.dart';

abstract class StoryPaginationEvents {}

class LoadMoreUserStories extends StoryPaginationEvents {}

class InitializePaginationStories extends StoryPaginationEvents {
  final List<UserEntity> initialStories;

  InitializePaginationStories({required this.initialStories});
}
