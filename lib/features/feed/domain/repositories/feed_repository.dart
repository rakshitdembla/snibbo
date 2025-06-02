import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';

/// Abstract contract defining all feed-related data operations
abstract class FeedRepository {
  // -- Feed Content Fetching --

  /// Gets posts from accounts the current user follows
  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getFollowingPosts(String tokenId, int page, int limit);

  /// Gets all posts available (discover feed)
  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getAllPosts(int page, int limit);

  /// Gets stories from accounts the current user follows
  Future<(bool success, List<UserEntity>? storyUsers, String? message)>
  getFollowingStory(String tokenId, int page, int limit);

  /// Gets stories created by the current user
  Future<(bool success, UserStoriesEntity? myStories, String? message)>
  getMyStories(String tokenId);

  // -- Post Interactions --
  /// Likes a post
  Future<(bool success, String? message)> likePost({
    required String postId,
    required String userId,
  });

  /// DisLikes a post
  Future<(bool success, String? message)> disLikepost({
    required String postId,
    required String userId,
  });

  /// Gets comments for a specific post
  Future<(bool success, List<PostCommentEntity>? postComments, String? message)>
  getPostComments(String postId);

  /// Gets users who liked a specific post
  Future<(bool success, List<UserEntity>? likedUser, String? message)>
  getPostLikedUsers(String postId);

  /// Saves any post to user saved posts
  Future<(bool success, String? message)> savePost({
    required String postId,
    required String userId,
  });

  /// Removes saved post from user saved posts
  Future<(bool success, String? message)> removeSavedPost({
    required String postId,
    required String userId,
  });

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
