import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';
import 'package:snibbo_app/features/user/domain/repositories/user_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class UserProfileUsecase {
  Future<(bool, ProfileEntity?, String?)> getUserProfile({
    required String username,
    required String userId,
  }) {
    return sl<UserRepository>().getUserProfile(
      username: username,
      userId: userId,
    );
  }
}
