import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/chats/domain/entities/chat_list_entity.dart';
import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';

abstract class ChatRepostitory {
  Future<(bool success, String? message)> blockUser({
    required String tokenId,
    required String username,
  });

  Future<(bool success, String? message)> unblockUser({
    required String tokenId,
    required String username,
  });
  Future<(bool success, List<UserEntity>? blockedUsers, String? message)>
  getBlockedUsers({
    required String tokenId,
    required int page,
    required int limit,
  });

  Future<(bool success, List<MessageEntity>? messages, String? message)>
  getMessages({
    required String tokenId,
    required String username,
    required int page,
    required int limit,
  });
  Future<(bool success, List<ChatListEntity>? chats, String? message)>
  getChats({required String tokenId, required int page, required int limit});
}
