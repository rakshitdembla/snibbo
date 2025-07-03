import 'package:flutter/material.dart';
import 'package:snibbo_app/core/local_data_manager/story_views_manager.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

class PostInteractionManager {
  static final Map<String, bool> likeStatus = {};
  static final Map<String, bool> savedStatus = {};
  static final Map<String, int> likeCount = {};
  static final Map<String, int> postCommentCount = {};

  //For comments
  static final Map<String, bool> commentLikeStatus = {};
  static final Map<String, int> commentLikeCount = {};
  static final Map<String, bool> replyLikeStatus = {};
  static final Map<String, int> replyLikeCount = {};

  static void clearAll() {
    likeStatus.clear();
    savedStatus.clear();
    likeCount.clear();
    commentLikeStatus.clear();
    commentLikeCount.clear();
    replyLikeStatus.clear();
    replyLikeCount.clear();
    postCommentCount.clear();
  }

  static void clearPosts({required List<PostEntity> posts}) {
    for (final post in posts) {
      final postId = post.id;
      debugPrint("Clearing data for post: $postId");
      likeStatus.remove(postId);
      savedStatus.remove(postId);
      likeCount.remove(postId);
      postCommentCount.remove(postId);
    }

    StoryViewsManager.clearStoriesByPosts(posts: posts);
  }
}
