import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/repositories/feed_repository.dart';

class FeedPostsUsecase {
  final FeedRepository feedRepository;

  FeedPostsUsecase({required this.feedRepository});
  Future<(bool success, String? message)> reactToPost(
    String postId,
    String userId,
    bool isDislike,
  ) {
    return feedRepository.reactToPost(postId, userId, isDislike);
  }

  Future<(bool success, List<PostCommentEntity>? postComments, String? message)>
  getPostComments(String postId) {
    return feedRepository.getPostComments(postId);
  }

  Future<(bool, List<UserEntity>?, String?)> getPostLikedUsers(String postId) {
    return feedRepository.getPostLikedUsers(postId);
  }
}
