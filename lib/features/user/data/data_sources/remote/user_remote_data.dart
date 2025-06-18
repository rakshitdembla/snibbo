import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/features/feed/data/models/post_model.dart';
import 'package:snibbo_app/core/models/user_model.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/user/data/models/profile_model.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';
import 'package:snibbo_app/service_locator.dart';

class UserRemoteData {
  // @ ----- Follow user -----
  Future<(bool success, String? message)> followUser({
    required String userId,
    required String username,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.followUser}/$username",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;
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

  // @ ----- Unfollow user -----
  Future<(bool success, String? message)> unfollowUser({
    required String userId,
    required String username,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.unfollowUser}/$username",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;
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

  // @ ----- Get user profile by username -----
  Future<(bool success, ProfileEntity? profileEntity, String? message)>
  getUserProfile({required String username, required String userId}) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.userProfile}/$username",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;
        if (response.statusCode == 200) {
          return (
            true,
            ProfileModel.fromJson(responseData["user"]).toEntity(),
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

  // @ ----- Get User Posts -----

  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getUserPosts({
    required int page,
    required int limit,
    required String username,
    required String userId,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.myPosts}/$username",
        queryParameters: {
          MyStrings.pageParam: page,
          MyStrings.limitParam: limit,
        },
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 200) {
          final postsJson = responseData["posts"] as List;
          final postEntities =
              postsJson.map((x) => PostModel.fromJson(x).toEntity()).toList();
          return (true, postEntities, "My posts fetched successfully.");
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

  //@ ---- Get User Saved Posts ----
  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getUserSavedPosts({
    required int page,
    required int limit,
    required String username,
    required String userId,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.savedPosts}/$username",
        queryParameters: {
          MyStrings.pageParam: page,
          MyStrings.limitParam: limit,
        },
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 200) {
          final postsJson = responseData["posts"] as List;
          final postEntities =
              postsJson.map((x) => PostModel.fromJson(x).toEntity()).toList();
          return (true, postEntities, "Saved posts fetched successfully.");
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

  // @ ----- Get User Followers -----
  Future<(bool success, List<UserEntity>? users, String? message)>
  getUserFollowers({
    required String username,
    required String userId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.userFollowers}/$username",
        queryParameters: {
          MyStrings.pageParam: page,
          MyStrings.limitParam: limit,
        },
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;
        if (response.statusCode == 200) {
          final usersJson = responseData["users"] as List;
          final users =
              usersJson.map((x) => UserModel.fromJson(x).toEntity()).toList();
          return (true, users, "Followers fetched successfully.");
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

  // @ ----- Get User Following -----
  Future<(bool success, List<UserEntity>? users, String? message)>
  getUserFollowing({
    required String username,
    required String userId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.userFollowings}/$username",
        queryParameters: {
          MyStrings.pageParam: page,
          MyStrings.limitParam: limit,
        },
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;
        if (response.statusCode == 200) {
          final usersJson = responseData["users"] as List;
          final users =
              usersJson.map((x) => UserModel.fromJson(x).toEntity()).toList();
          return (true, users, "Following fetched successfully.");
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

  // @ -- Search User --

  Future<(bool success, UserEntity? user, String? message)> searchUserByUsername({
  required String username,
}) async {
  try {
    final response = await sl<ApiService>().get(
      path: "${ApiRoutes.searchUser}/$username",
    );

    if (response != null) {
      final responseData = response.data;

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(responseData["user"]).toEntity();
        return (true, user, "User found successfully.");
      } else {
        return (false, null, responseData["message"]?.toString() ?? "Failed to fetch user.");
      }
    } else {
      return (false, null, "No response from server. Please try again later.");
    }
  } catch (e) {
    return (false, null, "Unexpected error occurred: ${e.toString()}");
  }
}

}
