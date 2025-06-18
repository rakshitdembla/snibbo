import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/user/domain/repositories/user_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class SearchUserUsecase {
  Future<(bool, UserEntity?, String?)> call({required String username}) {
    return sl<UserRepository>().searchUserByUsername(username: username);
  }
}
