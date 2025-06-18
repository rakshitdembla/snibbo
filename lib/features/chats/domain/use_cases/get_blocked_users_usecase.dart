import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/chats/domain/repositories/chat_repostitory.dart';
import 'package:snibbo_app/service_locator.dart';

class GetBlockedUsersUseCase {
  Future<(bool, List<UserEntity>?, String?)> call({
    required String tokenId,
    required int page,
    required int limit,
  }) {
    return sl<ChatRepostitory>().getBlockedUsers(
      tokenId: tokenId,
      page: page,
      limit: limit,
    );
  }
}
