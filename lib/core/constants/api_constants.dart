class ApiMainUrl {
  ApiMainUrl._();
  // Use this when running on emulator
  static String url_ = "http://127.0.0.1:3000/api";

  //
  static String baseUrl = "http://192.168.31.63:3000";

  //Jio AirFiber IP (Wireless Debugging)
  static String urlp = "http://192.168.31.213:3000/api";

  // Use this IP for iPhone to access local server on your Mac
  static String url = "http://192.168.31.63:3000/api";

  //RailwayWifi IP
  
}

class ApiEndPoints {
  ApiEndPoints._();

  static String auth = "/auth";
  static String posts = "/posts";
  static String story = "/story";
  static String report = "/report";
  static String user = "/user";
  static String chat = "/chat";
}

class ApiRoutes {
  ApiRoutes._();
  static String authRoute = "${ApiMainUrl.url}${ApiEndPoints.auth}";
  static String login = "$authRoute/login";
  static String register = "$authRoute/register";
  static String forgetPassword = "$authRoute/forget-password";

  static String postRoute = "${ApiMainUrl.url}${ApiEndPoints.posts}";
  static String followingPosts = "$postRoute/following-posts";
  static String allPosts = "$postRoute/all";
  static String likePost = "$postRoute/like";
  static String disLikePost = "$postRoute/dislike";
  static String postComments = "$postRoute/all-comments";
  static String commentReplies = "$postRoute/all-replies";
  static String postLikedUsers = "$postRoute/liked-users";
  static String createPost = "$postRoute/create";
  static String savePost = "$postRoute/save";
  static String removeSavedPost = "$postRoute/remove-saved";
  static String myPosts = "$postRoute/user-posts";
  static String savedPosts = "$postRoute/saved-posts";
  static String addComment = "$postRoute/add-comment";
  static String addReply = "$postRoute/add-reply";
  static String deleteComment = "$postRoute/remove-comment";
  static String deleteReply = "$postRoute/remove-reply";
  static String likeComment = "$postRoute/like-comment";
  static String dislikeComment = "$postRoute/dislike-comment";
  static String likeReply = "$postRoute/like-reply";
  static String dislikeReply = "$postRoute/dislike-reply";
  static String commentLikedUsers = "$postRoute/comment-likes";
  static String replyLikedUsers = "$postRoute/reply-likes";
  static String updatePost = "$postRoute/update";
  static String deletePost = "$postRoute/delete";

  static String storyRoute = "${ApiMainUrl.url}${ApiEndPoints.story}";
  static String followingStories = "$storyRoute/followings/stories";
  static String storyByUsername = "$storyRoute/user-stories";
  static String getMyStories = "$storyRoute/my-stories";
  static String createStory = "$storyRoute/create";
  static String viewStory = "$storyRoute/view";
  static String deleteStory = "$storyRoute/delete";
  static String storyViewers = "$storyRoute/view-users";

  static String userRoute = "${ApiMainUrl.url}${ApiEndPoints.user}";
  static String followUser = "$userRoute/follow";
  static String unfollowUser = "$userRoute/unfollow";
  static String userProfile = "$userRoute/profile";
  static String userFollowings = "$userRoute/followings";
  static String userFollowers= "$userRoute/followers";
  static String updateProfile= "$userRoute/update-profile";
  static String searchUser = "$userRoute/search-user";

  static String chatRoute = "${ApiMainUrl.url}${ApiEndPoints.chat}";
  static String blockUser = "$chatRoute/block";
  static String unblockUser = "$chatRoute/unblock";
  static String getBlockedUsers = "$chatRoute/blocked-users";
  static String getMessages = "$chatRoute/chats";
  static String getChats = "$chatRoute/chats-list";
}
