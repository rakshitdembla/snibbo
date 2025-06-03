import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/features/feed/data/models/post_model.dart';
import 'package:snibbo_app/features/feed/data/models/user_model.dart';
import 'package:snibbo_app/features/feed/data/models/user_stories_model.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/service_locator.dart';

class GetFeedRemoteData {
  // Get Followings Posts -->
  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getFollowingPosts(String tokenId, int page, int limit) async {
    try {
      final response = await sl<ApiService>().get(
        path: ApiRoutes.followingPosts,
        headers: {MyStrings.userIdHeader: tokenId},
        queryParameters: {
          MyStrings.pageParam: page,
          MyStrings.limitParam: limit,
        },
      );

      if (response != null) {
        final responseData = await response.data;
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
  getAllPosts(String userId,int page, int limit) async {
    try {
      final response = await sl<ApiService>().get(
        path: ApiRoutes.allPosts,
        headers: {MyStrings.userIdHeader: userId},
        queryParameters: {
          MyStrings.pageParam: page,
          MyStrings.limitParam: limit,
        },
      );

      if (response != null) {
        final responseData = await response.data;
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
  Future<(bool success, List<UserEntity>? storyUsers, String? message)>
  getFollowingStory(String tokenId, int page, int limit) async {
    try {
      final response = await sl<ApiService>().get(
        path: ApiRoutes.followingStories,
        headers: {MyStrings.userIdHeader: tokenId},
        queryParameters: {
          MyStrings.pageParam: page,
          MyStrings.limitParam: limit,
        },
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 200) {
          final List userStories = responseData["followings"] ?? [];
          return (
            true,
            List<UserEntity>.from(
              userStories.map((x) => UserModel.fromJson(x).toEntity()),
            ),
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

  //Get My Stories -->
  Future<(bool success, UserStoriesEntity? myStories, String? message)>
  getMyStories(String tokenId) async {
    try {
      final response = await sl<ApiService>().get(
        path: ApiRoutes.getMyStories,
        headers: {MyStrings.userIdHeader: tokenId},
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
}
