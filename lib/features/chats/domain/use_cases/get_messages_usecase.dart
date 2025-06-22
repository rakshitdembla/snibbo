import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';
import 'package:snibbo_app/features/chats/domain/repositories/chat_repostitory.dart';
import 'package:snibbo_app/service_locator.dart';

class GetMessagesUseCase {
  Future<(bool,String? chatId, List<MessageEntity>?, String?)> call({
    required String tokenId,
    required String username,
    required int page,
    required int limit,
  }) {
    return sl<ChatRepostitory>().getMessages(
      tokenId: tokenId,
      username: username,
      page: page,
      limit: limit,
    );
  }
}
