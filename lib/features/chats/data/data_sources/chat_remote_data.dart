import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/core/models/user_model.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/features/chats/data/models/chat_list_model.dart';
import 'package:snibbo_app/features/chats/data/models/message_model.dart';
import 'package:snibbo_app/features/chats/domain/entities/chat_list_entity.dart';
import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';
import 'package:snibbo_app/service_locator.dart';

class ChatRemoteData {
  Future<(bool success, String? message)> blockUser({
    required String tokenId,
    required String username,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.blockUser}/$username",
        headers: {MyStrings.userIdHeader: tokenId},
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 202) {
          return (true, "User blocked successfully.");
        } else {
          return (
            false,
            responseData["message"].toString(),
          );
        }
      } else {
        return (false, "No response from server. Please try again later.");
      }
    } catch (e) {
      return (false, "Unexpected error occurred: ${e.toString()}");
    }
  }

  // Unblock User -->
  Future<(bool success, String? message)> unblockUser({
    required String tokenId,
    required String username,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.unblockUser}/$username",
        headers: {MyStrings.userIdHeader: tokenId},
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 202) {
          return (true, "User unblocked successfully.");
        } else {
          return (
            false,
            responseData["message"].toString()
          );
        }
      } else {
        return (false, "No response from server. Please try again later.");
      }
    } catch (e) {
      return (false, "Unexpected error occurred: ${e.toString()}");
    }
  }

  // Get Blocked Users -->
  Future<(bool success, List<UserEntity>? blockedUsers, String? message)>
  getBlockedUsers({
    required String tokenId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: ApiRoutes.getBlockedUsers,
        headers: {MyStrings.userIdHeader: tokenId},
        queryParameters: {
          MyStrings.pageParam: page,
          MyStrings.limitParam: limit,
        },
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 200) {
          final List blocked = responseData["blockedUsers"] ?? [];
          return (
            true,
            List<UserEntity>.from(
              blocked.map((x) => UserModel.fromJson(x).toEntity()),
            ),
            "Blocked users fetched successfully.",
          );
        } else {
          return (
            false,
            null,
            responseData["message"].toString()
          );
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

  // Get Messages List -->
  Future<(bool success, List<MessageEntity>? messages, String? message)>
  getMessages({
    required String tokenId,
    required String username,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.getMessages}/$username",
        headers: {MyStrings.userIdHeader: tokenId},
        queryParameters: {
          MyStrings.pageParam: page,
          MyStrings.limitParam: limit,
        },
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 200) {
          final List messagesJson = responseData["messages"] ?? [];
          final messages =
              messagesJson
                  .map((x) => MessageModel.fromJson(x).toEntity())
                  .toList();

          return (true, messages, "Messages fetched successfully.");
        } else {
          return (
            false,
            null,
            responseData["message"].toString(),
          );
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

  // Get Chats List -->
  Future<(bool success, List<ChatListEntity>? chats, String? message)>
  getChats({
    required String tokenId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: ApiRoutes.getChats,
        headers: {MyStrings.userIdHeader: tokenId},
        queryParameters: {
          MyStrings.pageParam: page,
          MyStrings.limitParam: limit,
        },
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 200) {
          final List chatsJson = responseData["chats"] ?? [];
          final chatList =
              chatsJson
                  .map((x) => ChatListModel.fromJson(x).toEntity())
                  .toList();

          return (true, chatList, "Chats fetched successfully.");
        } else {
          return (
            false,
            null,
            responseData["message"].toString(),
          );
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
