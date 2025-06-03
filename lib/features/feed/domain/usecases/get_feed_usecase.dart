import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/features/feed/domain/repositories/feed_repository.dart';

class GetFeedPostsUsecase {
  final FeedRepository feedRepository;

  GetFeedPostsUsecase({required this.feedRepository});

  /// Retrieves posts from accounts that the current user follows
  /// [tokenId] - Authentication token of the current user
  /// Returns tuple containing success status, list of posts, and optional message
  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getFollowingPosts(String tokenId, int page, int limit) {
    return feedRepository.getFollowingPosts(tokenId, page, limit);
  }

  /// Retrieves all available posts (for discover/explore feed)
  /// [tokenId] - Authentication token of the current user
  /// Returns tuple containing success status, list of posts, and optional message
  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getAllPosts(String tokenId, int page, int limit) {
    return feedRepository.getAllPosts(tokenId,page, limit);
  }

  /// Retrieves stories from accounts that the current user follows
  /// [tokenId] - Authentication token of the current user
  /// Returns tuple containing success status, list of stories, and optional message
  Future<(bool success, List<UserEntity>? userStories, String? message)>
  getFollowingStories({
    required String tokenId,
    required int page,
    required int limit,
  }) {
    return feedRepository.getFollowingStory(tokenId, page, limit);
  }

  /// Retrieves stories by providing username
  /// [tokenId] - Authentication token of the current user
  /// Returns tuple containing success status, user stories, and optional message
  Future<(bool, UserStoriesEntity?, String?)> getMyStories(String tokenId) {
    return feedRepository.getMyStories(tokenId);
  }
}
