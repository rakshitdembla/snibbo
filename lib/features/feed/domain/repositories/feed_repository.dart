import 'package:snibbo_app/features/feed/domain/entities/following_story_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';

abstract class FeedRepository {
  // -- Get Feed
  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getFollowingPosts(String tokenId);

  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getAllPosts();

  Future<
    (
      bool success,
      List<FollowingStoryEntity>? followingStoryEntity,
      String? message,
    )
  >
  getFollowingStory(String tokenId);

  // -- Feed Post Interactions
  Future<(bool success, String? message)> reactToPost(
    String postId,
    String userId,
    bool isDislike,
  );

  Future<(bool success, List<PostCommentEntity>? postComments, String? message)>
  getPostComments(String postId);

  Future<(bool success, List<UserEntity>? likedUser, String? message)>
  getPostLikedUsers(String postId);

  // -- Story Interactions

  Future<(bool success, UserStoriesEntity? userStories, String? message)>
  getUserStories(String username);
}
