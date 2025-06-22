import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/chats/data/data_sources/chat_remote_data.dart';
import 'package:snibbo_app/features/chats/domain/entities/chat_list_entity.dart';
import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';
import 'package:snibbo_app/features/chats/domain/repositories/chat_repostitory.dart';
import 'package:snibbo_app/service_locator.dart';

class ChatRepositoryImpl implements ChatRepostitory {
  @override
  Future<(bool, String?)> blockUser({
    required String tokenId,
    required String username,
  }) {
    return sl<ChatRemoteData>().blockUser(tokenId: tokenId, username: username);
  }

  @override
  Future<(bool, List<UserEntity>?, String?)> getBlockedUsers({
    required String tokenId,
    required int page,
    required int limit,
  }) {
    return sl<ChatRemoteData>().getBlockedUsers(
      tokenId: tokenId,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<(bool, List<ChatListEntity>?, String?)> getChats({
    required String tokenId,
    required int page,
    required int limit,
  }) {
    return sl<ChatRemoteData>().getChats(
      tokenId: tokenId,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<(bool,String? chatId, List<MessageEntity>?, String?)> getMessages({
    required String tokenId,
    required String username,
    required int page,
    required int limit,
  }) {
    return sl<ChatRemoteData>().getMessages(
      tokenId: tokenId,
      username: username,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<(bool, String?)> unblockUser({
    required String tokenId,
    required String username,
  }) {
    return sl<ChatRemoteData>().unblockUser(
      tokenId: tokenId,
      username: username,
    );
  }
}
