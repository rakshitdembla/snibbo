import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/core/models/user_model.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/service_locator.dart';

class PostActionsRemoteData {
  // Like Post -->
  Future<(bool success, String? message)> likePost(
    String postId,
    String userId,
  ) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.likePost}/$postId",
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

  // DisLike Post -->
  Future<(bool success, String? message)> dislikePost(
    String postId,
    String userId,
  ) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.disLikePost}/$postId",
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

  // @ ----- Get Post Liked Users -----
  Future<(bool success, List<UserEntity>? users, String? message)>
  getPostLikedUsers({
    required String postId,
    required String userId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.postLikedUsers}/$postId",
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
          return (true, users, "Post liked users fetched successfully.");
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

  //SavePost
  Future<(bool success, String? message)> savePost({
    required String postId,
    required String userId,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.savePost}/$postId",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;

        if (response.statusCode == 202) {
          return (true, "Post saved successfully.");
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

  //Remove Saved Post
  Future<(bool success, String? message)> removeSavedPost({
    required String postId,
    required String userId,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.removeSavedPost}/$postId",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;

        if (response.statusCode == 202) {
          return (true, "Post removed from saved successfully.");
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

  // @ -- Update Post --
  Future<(bool success, String? message)> updatePost({
    required String postId,
    required String userId,
    required String caption,
  }) async {
    try {
      final response = await sl<ApiService>().patch(
        path: "${ApiRoutes.updatePost}/$postId",
        headers: {MyStrings.userIdHeader: userId},
        body: {MyStrings.postCaptions: caption},
      );

      if (response != null) {
        final responseData = response.data;
        return (response.statusCode == 202, responseData["message"].toString());
      } else {
        return (false, "No response from server. Please try again later.");
      }
    } catch (e) {
      return (false, "Unexpected error occurred: ${e.toString()}");
    }
  }

  // @ -- Delete Post --
  Future<(bool success, String? message)> deletePost({
    required String postId,
    required String userId,
  }) async {
    try {
      final response = await sl<ApiService>().delete(
        path: "${ApiRoutes.deletePost}/$postId",
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
}
