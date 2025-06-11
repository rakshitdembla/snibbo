import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';

abstract class PostCommentsRepository {
  Future<(bool success, String? message)> createComment({
    required String postId,
    required String userId,
    required String commentContent,
  });

  Future<(bool success, String? message)> createReply({
    required String commentId,
    required String userId,
    required String replyContent,
  });

  Future<(bool success, String? message)> deleteComment({
    required String commentId,
    required String userId,
  });

  Future<(bool success, String? message)> deleteReply({
    required String replyId,
    required String userId,
  });

  Future<(bool success, String? message)> likeComment({
    required String commentId,
    required String userId,
  });

  Future<(bool success, String? message)> dislikeComment({
    required String commentId,
    required String userId,
  });

  Future<(bool success, String? message)> likeReply({
    required String replyId,
    required String userId,
  });

  Future<(bool success, String? message)> dislikeReply({
    required String replyId,
    required String userId,
  });

  Future<
    ({bool success, List<PostCommentEntity>? postComments, String? message})
  >
  getPostComments({
    required String postId,
    required String userId,
    required int page,
    required int limit,
  });

  Future<
    ({bool success, List<CommentReplyEntity>? commentReplies, String? message})
  >
  getCommentReplies({
    required String commentId,
    required String userId,
    required int page,
    required int limit,
  });

    Future<(bool success, List<UserEntity>? users, String? message)>
  getReplyLikedUsers({
    required String replyId,
    required String userId,
    required int page,
    required int limit,
  });

    Future<(bool success, List<UserEntity>? users, String? message)>
  getCommentLikedUsers({
    required String commentId,
    required String userId,
    required int page,
    required int limit,
  });
}
