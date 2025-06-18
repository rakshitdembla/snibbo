import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';

/// Abstract contract defining all feed-related data operations
abstract class FeedRepository {
  // -- Feed Content Fetching --

  /// Gets posts from accounts the current user follows
  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getFollowingPosts(String tokenId, int page, int limit);

  /// Gets all posts available (discover feed)
  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getAllPosts(String userId,int page, int limit);

  /// Gets stories from accounts the current user follows
  Future<(bool success, List<UserEntity>? storyUsers, String? message)>
  getFollowingStory(String tokenId, int page, int limit);

  /// Gets stories created by the current user
  Future<(bool success, UserStoriesEntity? myStories, String? message)>
  getMyStories(String tokenId);

}
