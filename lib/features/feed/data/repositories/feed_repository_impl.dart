import 'package:snibbo_app/features/feed/data/data_sources/remote/feed_posts_remote_data.dart';
import 'package:snibbo_app/features/feed/data/data_sources/remote/feed_stories_remote_data.dart';
import 'package:snibbo_app/features/feed/data/data_sources/remote/get_feed_remote_data.dart';
import 'package:snibbo_app/features/feed/domain/entities/following_story_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/features/feed/domain/repositories/feed_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class FeedRepositoryImpl implements FeedRepository {
  @override
  Future<(bool, List<PostEntity>?, String?)> getFollowingPosts(String tokenId) {
    return sl<GetFeedRemoteData>().getFollowingPosts(tokenId);
  }

  @override
  Future<(bool, List<FollowingStoryEntity>?, String?)> getFollowingStory(
    String tokenId,
  ) {
    return sl<GetFeedRemoteData>().getFollowingStory(tokenId);
  }

  @override
  Future<(bool, List<PostEntity>?, String?)> getAllPosts() {
    return sl<GetFeedRemoteData>().getAllPosts();
  }

  @override
  Future<(bool, String?)> reactToPost(
    String postId,
    String userId,
    bool isDislike,
  ) {
    return sl<FeedPostsRemoteData>().reactToPost(postId, userId, isDislike);
  }

  @override
  Future<(bool, List<PostCommentEntity>?, String?)> getPostComments(
    String postId,
  ) {
    return sl<FeedPostsRemoteData>().getPostComments(postId);
  }

  @override
  Future<(bool, List<UserEntity>?, String?)> getPostLikedUsers(String postId) {
      return sl<FeedPostsRemoteData>().getPostLikedUsers(postId);
  
  }

  @override
  Future<(bool, UserStoriesEntity?, String?)> getUserStories(String username) {
   return sl<FeedStoriesRemoteData>().getUserStories(username);
  }
}
