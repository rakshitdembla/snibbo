import 'package:snibbo_app/core/local_data_manager/post_interaction_manager.dart';
import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart';

class ReplyStorageHelper {
  static final Map<String, List<CommentReplyEntity>> replies = {};
  static final Map<String, int> page = {};
  static final Map<String, bool> hasMore = {};
  static final Map<String, bool> isLoading = {};
  static final Map<String, int> repliesLength = {};

  static void clearAll() {
    replies.clear();
    page.clear();
    hasMore.clear();
    isLoading.clear();
    repliesLength.clear();
    PostInteractionManager.commentLikeCount.clear();
    PostInteractionManager.commentLikeStatus.clear();
    PostInteractionManager.replyLikeCount.clear();
    PostInteractionManager.replyLikeStatus.clear();
  }
}
