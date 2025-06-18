import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/user/domain/repositories/user_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class UserFollowingsUsecase {
  Future<(bool success, List<UserEntity>? users, String? message)> call({
    required String username,
    required String userId,
    required int page,
    required int limit,
  }) {
    return sl<UserRepository>().getUserFollowing(
      username: username,
      userId: userId,
      page: page,
      limit: limit,
    );
  }
}
