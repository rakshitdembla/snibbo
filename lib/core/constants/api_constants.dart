class ApiMainUrl {
  ApiMainUrl._();

static String url = "http://192.168.31.213:3000/api";
}

class ApiEndPoints {
  ApiEndPoints._();

  static String auth = "/auth";
  static String posts = "/posts";
  static String story = "/story";
  static String report = "/report";
  static String user = "/user";
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
  static String postLikedUsers = "$postRoute/liked-users";

  static String storyRoute = "${ApiMainUrl.url}${ApiEndPoints.story}";
  static String followingStories = "$storyRoute/followings/stories";
  static String storyByUsername = "$storyRoute/user-stories";
  static String getMyStories = "$storyRoute/my-stories";
}
