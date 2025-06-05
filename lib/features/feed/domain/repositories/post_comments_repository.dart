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
}
