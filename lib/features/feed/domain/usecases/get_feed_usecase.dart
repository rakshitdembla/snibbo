import 'package:snibbo_app/features/feed/domain/entities/story_preview_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/domain/repositories/feed_repository.dart';

class GetFeedPostsUsecase {
  final FeedRepository feedRepository;

  GetFeedPostsUsecase({required this.feedRepository});

  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getFollowingPosts(String tokenId) {
    return feedRepository.getFollowingPosts(tokenId);
  }

  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getAllPosts(String tokenId) {
    return feedRepository.getAllPosts();
  }

  Future<
    (
      bool success,
      List<UserStoryPreviewEntity>? userStoryPreviewEntity,
      String? message,
    )
  >
  getFollowingStories(String tokenId) {
    return feedRepository.getFollowingStory(tokenId);
  }

  Future<(bool, UserStoryPreviewEntity?, String?)> getMyStories(
    String tokenId,
  ) {
    return feedRepository.getMyStories(tokenId);
  }
}
