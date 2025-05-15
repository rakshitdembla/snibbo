import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/repositories/feed_repository.dart';

class PostsUsecase {
  final FeedRepository feedRepository;

  PostsUsecase({required this.feedRepository});

  /// Handles post like/dislike reactions
  /// [postId] - ID of the post to react to
  /// [userId] - ID of the user reacting
  /// [isDislike] - Whether the reaction is a dislike (true) or like (false)
  /// Returns tuple with success status and optional message
  Future<(bool success, String? message)> reactToPost(
    String postId,
    String userId,
    bool isDislike,
  ) {
    return feedRepository.reactToPost(postId, userId, isDislike);
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
}
