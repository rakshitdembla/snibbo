import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_comments_repository.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_interactions_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class PostsUsecase {
  final PostInteractionsRepository postInteractionsRepo =
      sl<PostInteractionsRepository>();
  final PostCommentsRepository postCommentsRepo = sl<PostCommentsRepository>();

  /// Handles post like reaction
  /// [postId] - ID of the post to react to
  /// [userId] - ID of the user reacting
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> likePost({
    required String postId,
    required String userId,
  }) {
    return postInteractionsRepo.likePost(userId: userId, postId: postId);
  }

  /// Handles post dislike reaction
  /// [postId] - ID of the post to react to
  /// [userId] - ID of the user reacting
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> disLike({
    required String postId,
    required String userId,
  }) {
    return postInteractionsRepo.disLikepost(userId: userId, postId: postId);
  }

  /// Retrieves comments for a specific post
  /// [postId] - ID of the post to fetch comments for
  /// Returns tuple with success status, list of comments, and optional message
  Future<(bool success, List<PostCommentEntity>? postComments, String? message)>
  getPostComments(String postId) {
    return postInteractionsRepo.getPostComments(postId);
  }

  /// Retrieves users who liked a specific post
  /// [postId] - ID of the post to fetch likers for
  /// Returns tuple with success status, list of users, and optional message
  Future<(bool, List<UserEntity>?, String?)> getPostLikedUsers(String postId) {
    return postInteractionsRepo.getPostLikedUsers(postId);
  }

  /// Saves any post to user saved posts
  /// [postId] - ID of the post to save
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> savePost({
    required String postId,
    required String userId,
  }) {
    return postInteractionsRepo.savePost(postId: postId, userId: userId);
  }

  /// Removes saved post from user saved posts
  /// [postId] - ID of the post to remove from saved posts
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> removeSavedPost({
    required String postId,
    required String userId,
  }) {
    return postInteractionsRepo.removeSavedPost(postId: postId, userId: userId);
  }

  /// Creates a new comment under a post
  /// [postId] - ID of the post to comment on
  /// [userId] - ID of the user commenting
  /// [commentContent] - Text of the comment
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> createComment({
    required String postId,
    required String userId,
    required String commentContent,
  }) {
    return postCommentsRepo.createComment(
      postId: postId,
      userId: userId,
      commentContent: commentContent,
    );
  }

  /// Creates a new reply under a comment
  /// [commentId] - ID of the comment to reply to
  /// [userId] - ID of the user replying
  /// [replyContent] - Text of the reply
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> createReply({
    required String commentId,
    required String userId,
    required String replyContent,
  }) {
    return postCommentsRepo.createReply(
      commentId: commentId,
      userId: userId,
      replyContent: replyContent,
    );
  }

  /// Deletes a comment
  /// [commentId] - ID of the comment to delete
  /// [userId] - ID of the user performing the deletion
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> deleteComment({
    required String commentId,
    required String userId,
  }) {
    return postCommentsRepo.deleteComment(commentId: commentId, userId: userId);
  }

  /// Deletes a reply
  /// [replyId] - ID of the reply to delete
  /// [userId] - ID of the user performing the deletion
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> deleteReply({
    required String replyId,
    required String userId,
  }) {
    return postCommentsRepo.deleteReply(replyId: replyId, userId: userId);
  }

  /// Likes a comment
  /// [commentId] - ID of the comment to like
  /// [userId] - ID of the user liking the comment
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> likeComment({
    required String commentId,
    required String userId,
  }) {
    return postCommentsRepo.likeComment(commentId: commentId, userId: userId);
  }

  /// Dislikes a comment
  /// [commentId] - ID of the comment to dislike
  /// [userId] - ID of the user disliking the comment
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> dislikeComment({
    required String commentId,
    required String userId,
  }) {
    return postCommentsRepo.dislikeComment(
      commentId: commentId,
      userId: userId,
    );
  }

  /// Likes a reply
  /// [replyId] - ID of the reply to like
  /// [userId] - ID of the user liking the reply
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> likeReply({
    required String replyId,
    required String userId,
  }) {
    return postCommentsRepo.likeReply(replyId: replyId, userId: userId);
  }

  /// Dislikes a reply
  /// [replyId] - ID of the reply to dislike
  /// [userId] - ID of the user disliking the reply
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> dislikeReply({
    required String replyId,
    required String userId,
  }) {
    return postCommentsRepo.dislikeReply(replyId: replyId, userId: userId);
  }
}
