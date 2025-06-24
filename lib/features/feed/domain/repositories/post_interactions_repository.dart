import 'package:snibbo_app/core/entities/user_entity.dart';

abstract class PostInteractionsRepository {
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

  /// Gets users who liked a specific post
  Future<(bool success, List<UserEntity>? users, String? message)>
  getPostLikedUsers({
    required String postId,
    required String userId,
    required int page,
    required int limit,
  });

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

  /// Update a post
  Future<(bool success, String? message)> updatePost({
    required String postId,
    required String userId,
    required String caption,
  });

  //Delete a post
  Future<(bool success, String? message)> deletePost({
    required String postId,
    required String userId,
  });

  //Search Post Liked User
  Future<(bool success, List<UserEntity>? users, String? message)>
  searchPostLikedUser({
    required String userId,
    required String userToSearch,
    required String postId,
  });
}
