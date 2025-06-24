import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
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
  Future<
    ({String? message, List<PostCommentEntity>? postComments, bool success})
  >
  getPostComments({
    required String postId,
    required String userId,
    required int page,
    required int limit,
  }) {
    return postCommentsRepo.getPostComments(
      postId: postId,
      userId: userId,
      page: page,
      limit: limit,
    );
  }

  /// Retrieves replies for a specific comment
  /// [commentId] - ID of the comment to fetch replies for
  /// Returns tuple with success status, list of replies, and optional message
  Future<
    ({List<CommentReplyEntity>? commentReplies, String? message, bool success})
  >
  getCommentReplies({
    required String commentId,
    required String userId,
    required int page,
    required int limit,
  }) {
    return postCommentsRepo.getCommentReplies(
      commentId: commentId,
      userId: userId,
      page: page,
      limit: limit,
    );
  }

  /// Retrieves users who liked a specific post
  /// [postId] - ID of the post to fetch likers for
  /// Returns tuple with success status, list of users, and optional message
  Future<(bool success, List<UserEntity>? users, String? message)>
  getPostLikedUsers({
    required String postId,
    required String userId,
    required int page,
    required int limit,
  }) {
    return postInteractionsRepo.getPostLikedUsers(
      postId: postId,
      userId: userId,
      page: page,
      limit: limit,
    );
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

  /// Fetches the list of users who liked a specific reply
  /// [replyId] - ID of the reply
  /// [userId] - ID of the current user making the request
  /// [page] - Pagination page number
  /// [limit] - Number of users per page
  /// Returns a tuple with success status, list of users, and optional message
  Future<(bool success, List<UserEntity>? users, String? message)>
  getReplyLikedUsers({
    required String replyId,
    required String userId,
    required int page,
    required int limit,
  }) {
    return postCommentsRepo.getReplyLikedUsers(
      replyId: replyId,
      userId: userId,
      page: page,
      limit: limit,
    );
  }

  /// Fetches the list of users who liked a specific comment
  /// [commentId] - ID of the comment
  /// [userId] - ID of the current user making the request
  /// [page] - Pagination page number
  /// [limit] - Number of users per page
  /// Returns a tuple with success status, list of users, and optional message
  Future<(bool success, List<UserEntity>? users, String? message)>
  getCommentLikedUsers({
    required String commentId,
    required String userId,
    required int page,
    required int limit,
  }) {
    return postCommentsRepo.getCommentLikedUsers(
      commentId: commentId,
      userId: userId,
      page: page,
      limit: limit,
    );
  }

  /// Updates an post of the user
  /// [postId] - ID of the post
  /// [userId] - ID of the current user making the request
  /// Returns a tuple with success status, and optional message
  Future<(bool, String?)> updatePost({
    required String postId,
    required String userId,
    required String caption,
  }) {
    return sl<PostInteractionsRepository>().updatePost(
      postId: postId,
      userId: userId,
      caption: caption,
    );
  }

  /// Deletes a post of the user
  /// [postId] - ID of the post
  /// [userId] - ID of the current user making the request
  /// Returns a tuple with success status and optional message
  Future<(bool, String?)> deletePost({
    required String postId,
    required String userId,
  }) {
    return sl<PostInteractionsRepository>().deletePost(
      postId: postId,
      userId: userId,
    );
  }

  /// Search post liked user
  /// [postId] - ID of the post
  /// [userId] - ID of the current user making the request
  /// [userToSearch] - User to search
  /// Returns a tuple with success status, list of users and optional message
  Future<(bool success, List<UserEntity>? users, String? message)>
  searchPostLikedUser({
    required String userId,
    required String userToSearch,
    required String postId,
  }) {
    return sl<PostInteractionsRepository>().searchPostLikedUser(
      userId: userId,
      userToSearch: userToSearch,
      postId: postId,
    );
  }

  /// Search post liked user
  /// [commentId] - ID of the comment
  /// [userId] - ID of the current user making the request
  /// [userToSearch] - User to search
  /// Returns a tuple with success status, list of users and optional message
  Future<(bool success, List<UserEntity>? users, String? message)>
  searchCommentLikedUser({
    required String userId,
    required String userToSearch,
    required String commentId,
  }) {
    return sl<PostCommentsRepository>().searchCommentLikedUser(
      userId: userId,
      userToSearch: userToSearch,
      commentId: commentId,
    );
  }

  /// Search post liked user
  /// [replyId] - ID of the reply
  /// [userId] - ID of the current user making the request
  /// [userToSearch] - User to search
  /// Returns a tuple with success status, list of users and optional message
  Future<(bool success, List<UserEntity>? users, String? message)>
  searchReplyLikedUser({
    required String userId,
    required String userToSearch,
    required String commentId,
  }) {
    return sl<PostCommentsRepository>().searchReplyLikedUser(
      userId: userId,
      userToSearch: userToSearch,
      commentId: commentId,
    );
  }
}
