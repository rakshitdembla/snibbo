class PostInteractionManager {
  static final Map<String, bool> likeStatus = {};
  static final Map<String, bool> savedStatus = {};
  static final Map<String, int> likeCount = {};
  static final Map<String, bool> commentLikeStatus = {};
  static final Map<String, int> commentLikeCount = {};
  static final Map<String, bool> replyLikeStatus = {};
  static final Map<String, int> replyLikeCount = {};
  static final Map<String,int> postCommentCount = {};

  static void clear() {
    likeStatus.clear();
    savedStatus.clear();
    likeCount.clear();
    commentLikeStatus.clear();
    commentLikeCount.clear();
    replyLikeStatus.clear();
    replyLikeCount.clear();
    postCommentCount.clear();
  }
}
