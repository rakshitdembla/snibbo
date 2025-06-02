import 'package:snibbo_app/features/user/domain/repositories/user_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class UnfollowUsecase {
  Future<(bool success, String? message)> call({
    required String userId,
    required String username,
  }) {
    return sl<UserRepository>().unfollowUser(userId: userId, username: username);
  }
}
