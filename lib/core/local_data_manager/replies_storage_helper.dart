import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart';

class ReplyStorageHelper {
  static final Map<String, List<CommentReplyEntity>> replies = {};
  static final Map<String, int> page = {};
  static final Map<String, bool> hasMore = {};
  static final Map<String, bool> isLoading = {};
  static final Map<String,int> repliesLength = {};

  static void clear() {
    replies.clear();
    page.clear();
    hasMore.clear();
    isLoading.clear();
    repliesLength.clear();
  }
}
