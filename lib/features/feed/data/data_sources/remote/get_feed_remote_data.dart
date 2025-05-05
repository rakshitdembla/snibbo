import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/features/feed/data/models/following_story_model.dart';
import 'package:snibbo_app/features/feed/data/models/post_model.dart';
import 'package:snibbo_app/features/feed/domain/entities/following_story_entity.dart';

import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/service_locator.dart';

class GetFeedRemoteData {
  // Get Followings Posts -->
  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getFollowingPosts(String tokenId) async {
    try {
      final response = await sl<ApiService>().get(
        path: ApiRoutes.followingPosts,
        headers: {MyStrings.userIdHeader: tokenId},
      );

      if (response != null) {
        final responseData = response.data;
        if (response.statusCode == 200) {
          final postsJson = responseData["posts"] as List;
          final postEntities =
              postsJson.map((x) => PostModel.fromJson(x).toEntity()).toList();
          return (true, postEntities, "Data fetched successfully.");
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

  // Get All Posts -->
  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getAllPosts() async {
    try {
      final response = await sl<ApiService>().get(path: ApiRoutes.allPosts);

      if (response != null) {
        final responseData = response.data;
        if (response.statusCode == 200) {
          final postsJson = responseData["posts"] as List;
          final postEntities =
              postsJson.map((x) => PostModel.fromJson(x).toEntity()).toList();
          return (true, postEntities, "Data fetched successfully.");
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

  // Get Followings Stories -->
  Future<
    (
      bool success,
      List<FollowingStoryEntity>? followingStoryEntity,
      String? message,
    )
  >
  getFollowingStory(String tokenId) async {
    try {
      final response = await sl<ApiService>().get(
        path: ApiRoutes.followingStories,
        headers: {MyStrings.userIdHeader: tokenId},
      );

      if (response != null) {
        final responseData = response.data;
        if (response.statusCode == 200) {
          final List userStories = responseData["stories"]?["followings"] ?? [];
          return (
            true,
            userStories
                    .map((x) => FollowingStoryModel.fromJson(x).toEntity())
                    .toList()
                as List<FollowingStoryEntity>?,
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
