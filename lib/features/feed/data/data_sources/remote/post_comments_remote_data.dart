import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/features/feed/data/models/post_comment_model.dart';
import 'package:snibbo_app/features/feed/data/models/comment_reply_model.dart';
import 'package:snibbo_app/features/feed/data/models/user_model.dart';
import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';

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

  // Get Posts Comments -->
  Future<
    ({bool success, List<PostCommentEntity>? postComments, String? message})
  >
  getPostComments({
    required String postId,
    required String userId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.postComments}/$postId",
        headers: {MyStrings.userIdHeader: userId},
        queryParameters: {
          MyStrings.pageParam: page,
          MyStrings.limitParam: limit,
        },
      );

      if (response != null) {
        final responseData = response.data;

        if (response.statusCode == 200) {
          List postComments = responseData["comments"];
          List<PostCommentEntity> comments =
              postComments
                  .map((x) => PostCommentModel.fromJson(x).toEntity())
                  .toList();

          return (
            success: true,
            postComments: comments,
            message: "Data fetched successfully.",
          );
        } else {
          return (
            success: false,
            postComments: null,
            message: responseData["message"].toString(),
          );
        }
      } else {
        return (
          success: false,
          postComments: null,
          message: "No response from server. Please try again later.",
        );
      }
    } catch (e) {
      return (
        success: false,
        postComments: null,
        message: "Unexpected error occurred: ${e.toString()}",
      );
    }
  }

  // Get Comment Replies -->

  Future<
    ({bool success, List<CommentReplyEntity>? commentReplies, String? message})
  >
  getCommentReplies({
    required String commentId,
    required String userId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.commentReplies}/$commentId",
        headers: {MyStrings.userIdHeader: userId},
        queryParameters: {
          MyStrings.pageParam: page,
          MyStrings.limitParam: limit,
        },
      );

      if (response != null) {
        final responseData = response.data;

        if (response.statusCode == 200) {
          List replies = responseData["replies"];
          List<CommentReplyEntity> replyEntities =
              replies
                  .map((x) => CommentReplyModel.fromJson(x).toEntity())
                  .toList();

          return (
            success: true,
            commentReplies: replyEntities,
            message: "Replies fetched successfully.",
          );
        } else {
          return (
            success: false,
            commentReplies: null,
            message: responseData["message"].toString(),
          );
        }
      } else {
        return (
          success: false,
          commentReplies: null,
          message: "No response from server. Please try again later.",
        );
      }
    } catch (e) {
      return (
        success: false,
        commentReplies: null,
        message: "Unexpected error occurred: ${e.toString()}",
      );
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

  // Get Comment Liked Users
  Future<(bool success, List<UserEntity>? users, String? message)>
  getCommentLikedUsers({
    required String commentId,
    required String userId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.commentLikedUsers}/$commentId",
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
          return (true, users, "Comment liked users fetched successfully.");
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

  // Get Reply Liked Users
  Future<(bool success, List<UserEntity>? users, String? message)>
  getReplyLikedUsers({
    required String replyId,
    required String userId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.replyLikedUsers}/$replyId",
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
          return (true, users, "Reply liked users fetched successfully.");
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
