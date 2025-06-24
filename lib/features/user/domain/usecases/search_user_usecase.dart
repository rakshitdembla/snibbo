import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/user/domain/repositories/user_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class SearchUserUsecase {
  Future<(bool success, List<UserEntity>? users, String? message)> call({
    required String username,
    required String userId,
  }) {
    return sl<UserRepository>().searchUserByUsername(
      username: username,
      userId: userId,
    );
  }
}
