import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/features/feed/data/models/user_model.dart';
import 'package:snibbo_app/features/feed/data/models/user_stories_model.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
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
        final responseData = await response.data;
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

  // Add Viewer to Story -->
  Future<(bool success, String? message)> viewStory({
    required String userId,
    required String storyId,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.viewStory}/$storyId",
          headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 202) {
          return (true, responseData["message"].toString());
        } else {
          return (false, responseData["message"].toString());
        }
      } else {
        return (false, "No response from server. Please try again later.");
      }
    } catch (e) {
      return (false, "Unexpected error occurred: ${e.toString()}");
    }
  }

  // Delete Story -->
  Future<(bool success, String? message)> deleteStory({
    required String userId,
    required String storyId,
  }) async {
    try {
      final response = await sl<ApiService>().delete(
        path: "${ApiRoutes.deleteStory}/$storyId",
           headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 202) {
          return (true, responseData["message"].toString());
        } else {
          return (false, responseData["message"].toString());
        }
      } else {
        return (false, "No response from server. Please try again later.");
      }
    } catch (e) {
      return (false, "Unexpected error occurred: ${e.toString()}");
    }
  }

  // Get Story Viewers -->
  Future<(bool success, List<UserEntity>? users, String? message)>
  storyViewers({required String userId, required String storyId}) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.storyViewers}/$storyId",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 200) {
          List usersList = responseData["storyViews"]?["storyViews"];
          return (
            true,
            usersList.map((x) => UserModel.fromJson(x).toEntity()).toList(),
            responseData["message"].toString(),
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
