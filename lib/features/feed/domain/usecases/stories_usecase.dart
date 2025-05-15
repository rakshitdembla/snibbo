import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/features/feed/domain/repositories/feed_repository.dart';

/// Handles story-related business logic and acts as an intermediary
/// between presentation layer and data layer for story operations
class StoriesUsecase {
  final FeedRepository feedRepository;

  StoriesUsecase({required this.feedRepository});

  /// Retrieves stories for a specific user
  /// [username] - Username of the user whose stories to fetch
  /// Returns tuple with success status, story data, and optional message
  Future<(bool success, UserStoriesEntity? userStories, String? message)>
  getUserStories(String username) {
    return feedRepository.getUserStories(username);
  }

  /// Records a story view event
  /// [userId] - ID of the user viewing the story
  /// [storyId] - ID of the story being viewed
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> viewStory({
    required String userId,
    required String storyId,
  }) {
    return feedRepository.viewStory(userId: userId, storyId: storyId);
  }

  /// Deletes a specific story
  /// [userId] - ID of the user who owns the story
  /// [storyId] - ID of the story to delete
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> deleteStory({
    required String userId,
    required String storyId,
  }) {
    return feedRepository.deleteStory(userId: userId, storyId: storyId);
  }

  /// Retrieves viewers for a specific story
  /// [userId] - ID of the user who owns the story
  /// [storyId] - ID of the story to fetch viewers for
  /// Returns tuple with success status, list of viewers, and optional message
  Future<(bool success, List<UserEntity>? users, String? message)>
  storyViewers({required String userId, required String storyId}) {
    return feedRepository.storyViewers(userId: userId, storyId: storyId);
  }
}