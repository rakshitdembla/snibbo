import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/repositories/feed_repository.dart';

class PostsUsecase {
  final FeedRepository feedRepository;

  PostsUsecase({required this.feedRepository});

  /// Handles post like reaction
  /// [postId] - ID of the post to react to
  /// [userId] - ID of the user reacting
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> likePost({
    required String postId,
    required String userId,
  }) {
    return feedRepository.likePost(userId: userId, postId: postId);
  }

  /// Handles post like reaction
  /// [postId] - ID of the post to react to
  /// [userId] - ID of the user reacting
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> disLike({
    required String postId,
    required String userId,
  }) {
    return feedRepository.disLikepost(userId: userId, postId: postId);
  }

  /// Retrieves comments for a specific post
  /// [postId] - ID of the post to fetch comments for
  /// Returns tuple with success status, list of comments, and optional message
  Future<(bool success, List<PostCommentEntity>? postComments, String? message)>
  getPostComments(String postId) {
    return feedRepository.getPostComments(postId);
  }

  /// Retrieves users who liked a specific post
  /// [postId] - ID of the post to fetch likers for
  /// Returns tuple with success status, list of users, and optional message
  Future<(bool, List<UserEntity>?, String?)> getPostLikedUsers(String postId) {
    return feedRepository.getPostLikedUsers(postId);
  }

  /// Saves any post to user saved posts
  /// [postId] - ID of the post to save
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> savePost({
    required String postId,
    required String userId,
  }) {
    return feedRepository.savePost(postId: postId, userId: userId);
  }

  /// Removes saved post from user saved posts
  /// [postId] - ID of the post to remove from saved posts
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> removeSavedPost({
    required String postId,
    required String userId,
  }) {
    return feedRepository.removeSavedPost(postId: postId, userId: userId);
  }
}
