import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';

abstract class UserRepository {
  Future<(bool success, String? message)> followUser({
    required String userId,
    required String username,
  });
  Future<(bool success, String? message)> unfollowUser({
    required String userId,
    required String username,
  });

  Future<(bool success, ProfileEntity? profileEntity, String? message)>
  getUserProfile({required String username, required String userId});
}
