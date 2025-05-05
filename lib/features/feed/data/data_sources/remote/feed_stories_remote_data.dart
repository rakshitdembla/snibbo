import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/features/feed/data/models/user_stories_model.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/service_locator.dart';

class FeedStoriesRemoteData {
  
    // Get User Stories By Username -->
  Future<(bool success, UserStoriesEntity? userStories, String? message)>
  getUserStories(String username) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.storyByUsername}/$username",
      );

      if (response != null) {
        final responseData = response.data;
        if (response.statusCode == 200) {
          return (
            true,
            UserStoriesModel.fromJson(responseData["user"]).toEntity(),
            "Data fetched successfully.",
          );
        } else {
          return (false, null, responseData["message"].toString());
        }
      } else {
        return (
          false,
          null,
          "No response from server. Please try again later.",
        );
      }
    } catch (e) {
      return (false, null, "Unexpected error occurred: ${e.toString()}");
    }
  }
}
