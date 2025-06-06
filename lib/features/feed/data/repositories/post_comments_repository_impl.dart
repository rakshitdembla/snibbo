import 'package:snibbo_app/features/feed/data/data_sources/remote/post_comments_remote_data.dart';
import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_comments_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class PostCommentsRepositoryImpl implements PostCommentsRepository {
  final _remoteData = sl<PostCommentsRemoteData>();

  @override
  Future<(bool success, String? message)> createComment({
    required String postId,
    required String userId,
    required String commentContent,
  }) {
    return _remoteData.createComment(
      postId: postId,
      userId: userId,
      commentContent: commentContent,
    );
  }

  @override
  Future<(bool success, String? message)> createReply({
    required String commentId,
    required String userId,
    required String replyContent,
  }) {
    return _remoteData.createReply(
      commentId: commentId,
      userId: userId,
      replyContent: replyContent,
    );
  }

  @override
  Future<(bool success, String? message)> deleteComment({
    required String commentId,
    required String userId,
  }) {
    return _remoteData.deleteComment(commentId: commentId, userId: userId);
  }

  @override
  Future<(bool success, String? message)> deleteReply({
    required String replyId,
    required String userId,
  }) {
    return _remoteData.deleteReply(replyId: replyId, userId: userId);
  }

  @override
  Future<(bool success, String? message)> likeComment({
    required String commentId,
    required String userId,
  }) {
    return _remoteData.likeComment(commentId: commentId, userId: userId);
  }

  @override
  Future<(bool success, String? message)> dislikeComment({
    required String commentId,
    required String userId,
  }) {
    return _remoteData.dislikeComment(commentId: commentId, userId: userId);
  }

  @override
  Future<(bool success, String? message)> likeReply({
    required String replyId,
    required String userId,
  }) {
    return _remoteData.likeReply(replyId: replyId, userId: userId);
  }

  @override
  Future<(bool success, String? message)> dislikeReply({
    required String replyId,
    required String userId,
  }) {
    return _remoteData.dislikeReply(replyId: replyId, userId: userId);
  }

  @override
  Future<
    ({List<CommentReplyEntity>? commentReplies, String? message, bool success})
  >
  getCommentReplies({
    required String commentId,
    required String userId,
    required int page,
    required int limit,
  }) {
    return _remoteData.getCommentReplies(
      commentId: commentId,
      userId: userId,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<
    ({String? message, List<PostCommentEntity>? postComments, bool success})
  >
  getPostComments({
    required String postId,
    required String userId,
    required int page,
    required int limit,
  }) {
    return _remoteData.getPostComments(
      postId: postId,
      userId: userId,
      page: page,
      limit: limit,
    );
  }
}
