import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/features/feed/data/models/post_comment_model.dart';
import 'package:snibbo_app/features/feed/data/models/user_model.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/service_locator.dart';

class FeedPostsRemoteData {
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

  // Get Posts Comments -->
  Future<(bool success, List<PostCommentEntity>? postComments, String? message)>
  getPostComments(String postId) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.postComments}/$postId",
      );

      if (response != null) {
        final responseData = response.data;

        if (response.statusCode == 200) {
          List postComments = responseData["comments"]?["postComments"];
          List<PostCommentEntity> comments =
              postComments
                  .map((x) => PostCommentModel.fromJson(x).toEntity())
                  .toList();
          return (true, comments, "Data fetched successfully.");
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

  // Get Post Liked User -->
  Future<(bool success, List<UserEntity>? likedUser, String? message)>
  getPostLikedUsers(String postId) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.postLikedUsers}/$postId",
      );

      if (response != null) {
        final responseData = response.data;

        if (response.statusCode == 200) {
          List postLikes = responseData["users"]?["postLikes"];
          List<UserEntity> likedUsers =
              postLikes.map((x) => UserModel.fromJson(x).toEntity()).toList();
          return (true, likedUsers, "Data fetched successfully.");
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
}
