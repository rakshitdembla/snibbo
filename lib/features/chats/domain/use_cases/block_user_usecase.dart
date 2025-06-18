import 'package:snibbo_app/features/chats/domain/repositories/chat_repostitory.dart';
import 'package:snibbo_app/service_locator.dart';

class BlockUserUseCase {
  Future<(bool, String?)> call({
    required String tokenId,
    required String username,
  }) {
    return sl<ChatRepostitory>().blockUser(
      tokenId: tokenId,
      username: username,
    );
  }
}
