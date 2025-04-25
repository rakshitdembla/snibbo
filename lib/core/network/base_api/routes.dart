import 'package:snibbo_app/core/network/base_api/end_points.dart';
import 'package:snibbo_app/core/network/base_api/main_url.dart';

class ApiRoutes{

  ApiRoutes._();

  static String login = "${ApiMainUrl.url}${ApiEndPoints.auth}/login";
  static String register = "${ApiMainUrl.url}${ApiEndPoints.auth}/register";
  
}