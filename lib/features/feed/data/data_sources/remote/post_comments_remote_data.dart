import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/service_locator.dart';

class PostCommentsRemoteData {
  // Adds a new comment to a post.
  Future<(bool success, String? message)> createComment({
    required String postId,
    required String userId,
    required String commentContent,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.addComment}/$postId",
        headers: {MyStrings.userIdHeader: userId},
        body: {MyStrings.commentContent: commentContent},
      );

      if (response != null) {
        final responseData = response.data;

        if (response.statusCode == 201 || responseData["success"] == true) {
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

  // Adds a new reply to a comment.
  Future<(bool success, String? message)> createReply({
    required String commentId,
    required String userId,
    required String replyContent,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.addReply}/$commentId",
        headers: {MyStrings.userIdHeader: userId},
        body: {MyStrings.replyContent: replyContent},
      );

      if (response != null) {
        final responseData = response.data;

        if (response.statusCode == 201 || responseData["success"] == true) {
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

  // Deletes an existing comment by ID.
  Future<(bool success, String? message)> deleteComment({
    required String commentId,
    required String userId,
  }) async {
    try {
      final response = await sl<ApiService>().delete(
        path: "${ApiRoutes.deleteComment}/$commentId",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;
        return (
          responseData["success"] == true,
          responseData["message"].toString(),
        );
      } else {
        return (false, "No response from server. Please try again later.");
      }
    } catch (e) {
      return (false, "Unexpected error occurred: ${e.toString()}");
    }
  }

  // Deletes an existing reply by ID.
  Future<(bool success, String? message)> deleteReply({
    required String replyId,
    required String userId,
  }) async {
    try {
      final response = await sl<ApiService>().delete(
        path: "${ApiRoutes.deleteReply}/$replyId",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;
        return (
          responseData["success"] == true,
          responseData["message"].toString(),
        );
      } else {
        return (false, "No response from server. Please try again later.");
      }
    } catch (e) {
      return (false, "Unexpected error occurred: ${e.toString()}");
    }
  }

  // Likes a comment by its ID.
  Future<(bool success, String? message)> likeComment({
    required String commentId,
    required String userId,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.likeComment}/$commentId",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;
        return (
          responseData["success"] == true,
          responseData["message"].toString(),
        );
      } else {
        return (false, "No response from server. Please try again later.");
      }
    } catch (e) {
      return (false, "Unexpected error occurred: ${e.toString()}");
    }
  }

  // Removes like from a comment by its ID.
  Future<(bool success, String? message)> dislikeComment({
    required String commentId,
    required String userId,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.dislikeComment}/$commentId",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;
        return (
          responseData["success"] == true,
          responseData["message"].toString(),
        );
      } else {
        return (false, "No response from server. Please try again later.");
      }
    } catch (e) {
      return (false, "Unexpected error occurred: ${e.toString()}");
    }
  }

  // Likes a reply by its ID.
  Future<(bool success, String? message)> likeReply({
    required String replyId,
    required String userId,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.likeReply}/$replyId",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;
        return (
          responseData["success"] == true,
          responseData["message"].toString(),
        );
      } else {
        return (false, "No response from server. Please try again later.");
      }
    } catch (e) {
      return (false, "Unexpected error occurred: ${e.toString()}");
    }
  }

  // Removes like from a reply by its ID.
  Future<(bool success, String? message)> dislikeReply({
    required String replyId,
    required String userId,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.dislikeReply}/$replyId",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;
        return (
          responseData["success"] == true,
          responseData["message"].toString(),
        );
      } else {
        return (false, "No response from server. Please try again later.");
      }
    } catch (e) {
      return (false, "Unexpected error occurred: ${e.toString()}");
    }
  }
}
