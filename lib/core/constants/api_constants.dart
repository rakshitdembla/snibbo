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

  static String login = "${ApiMainUrl.url}${ApiEndPoints.auth}/login";
  static String register = "${ApiMainUrl.url}${ApiEndPoints.auth}/register";
}
