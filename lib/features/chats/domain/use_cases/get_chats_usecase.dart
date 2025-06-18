import 'package:snibbo_app/features/chats/domain/entities/chat_list_entity.dart';
import 'package:snibbo_app/features/chats/domain/repositories/chat_repostitory.dart';
import 'package:snibbo_app/service_locator.dart';

class GetChatsUseCase {
  Future<(bool, List<ChatListEntity>?, String?)> call({
    required String tokenId,
    required int page,
    required int limit,
  }) {
    return sl<ChatRepostitory>().getChats(
      tokenId: tokenId,
      page: page,
      limit: limit,
    );
  }
}
