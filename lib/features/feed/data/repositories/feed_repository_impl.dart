import 'package:snibbo_app/features/feed/data/data_sources/remote/get_feed_remote_data.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/features/feed/domain/repositories/feed_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class FeedRepositoryImpl implements FeedRepository {
  @override
  Future<(bool, List<PostEntity>?, String?)> getFollowingPosts(
    String tokenId,
    int page,
    int limit,
  ) {
    return sl<GetFeedRemoteData>().getFollowingPosts(tokenId, page, limit);
  }

  @override
  Future<(bool, List<UserEntity>? userStories, String?)> getFollowingStory(
    String tokenId,
    int page,
    int limit,
  ) {
    return sl<GetFeedRemoteData>().getFollowingStory(tokenId, page, limit);
  }

  @override
  Future<(bool, List<PostEntity>?, String?)> getAllPosts(String userId,int page, int limit) {
    return sl<GetFeedRemoteData>().getAllPosts(userId,page, limit);
  }

  @override
  Future<(bool, UserStoriesEntity?, String?)> getMyStories(String tokenId) {
    return sl<GetFeedRemoteData>().getMyStories(tokenId);
  }



}
