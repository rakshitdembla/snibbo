import 'package:snibbo_app/core/local_data_manager/follow_status_manager.dart';
import 'package:snibbo_app/core/local_data_manager/post_interaction_manager.dart';
import 'package:snibbo_app/core/local_data_manager/profile/user_posts_helper.dart';
import 'package:snibbo_app/core/local_data_manager/profile/user_saved_posts_helper.dart';
import 'package:snibbo_app/core/local_data_manager/replies_storage_helper.dart';
import 'package:snibbo_app/core/local_data_manager/story_views_manager.dart';

class CleanLocalData {
  static void clearAllLocalData() {
    // Clear UserPostsHelper
    UserPostsHelper.posts.clear();
    UserPostsHelper.page.clear();
    UserPostsHelper.isLoading.clear();
    UserPostsHelper.hasMore.clear();

    // Clear UserSavedPostsHelper
    UserSavedPostsHelper.posts.clear();
    UserSavedPostsHelper.page.clear();
    UserSavedPostsHelper.isLoading.clear();
    UserSavedPostsHelper.hasMore.clear();

    // Clear FollowStatusManager
    FollowStatusManager.isAlreadyFollwing.clear();

    // Clear PostInteractionManager
    PostInteractionManager.likeStatus.clear();
    PostInteractionManager.savedStatus.clear();
    PostInteractionManager.likeCount.clear();
    PostInteractionManager.postCommentCount.clear();
    PostInteractionManager.commentLikeStatus.clear();
    PostInteractionManager.commentLikeCount.clear();
    PostInteractionManager.replyLikeStatus.clear();
    PostInteractionManager.replyLikeCount.clear();

    // Clear ReplyStorageHelper
    ReplyStorageHelper.replies.clear();
    ReplyStorageHelper.page.clear();
    ReplyStorageHelper.hasMore.clear();
    ReplyStorageHelper.isLoading.clear();
    ReplyStorageHelper.repliesLength.clear();

    // Clear StoryViewsManager
    StoryViewsManager.storyViewStatus.clear();
    StoryViewsManager.refreshTrigger.value++;
  }
}
