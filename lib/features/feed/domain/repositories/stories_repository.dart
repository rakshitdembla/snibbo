import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';

abstract class StoriesRepository {
  // -- Story Interactions --
  /// Gets stories for a specific user by username
  Future<(bool success, UserStoriesEntity? userStories, String? message)>
  getUserStories(String username);

  /// Records a story view
  Future<(bool success, String? message)> viewStory({
    required String userId,
    required String storyId,
  });

  /// Deletes a story
  Future<(bool success, String? message)> deleteStory({
    required String userId,
    required String storyId,
  });

  /// Gets viewers for a specific story
  Future<(bool success, List<UserEntity>? users, String? message)>
  storyViewers({required String userId, required String storyId});
}
