import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/user/data/data_sources/remote/user_remote_data.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';
import 'package:snibbo_app/features/user/domain/repositories/user_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<(bool, String?)> followUser({
    required String userId,
    required String username,
  }) {
    return sl<UserRemoteData>().followUser(userId: userId, username: username);
  }

  @override
  Future<(bool, String?)> unfollowUser({
    required String userId,
    required String username,
  }) {
    return sl<UserRemoteData>().unfollowUser(
      userId: userId,
      username: username,
    );
  }

  @override
  Future<(bool, ProfileEntity?, String?)> getUserProfile({
    required String username,
    required String userId,
  }) {
    return sl<UserRemoteData>().getUserProfile(
      username: username,
      userId: userId,
    );
  }

  @override
  Future<(bool, List<PostEntity>?, String?)> getUserPosts({
    required int page,
    required int limit,
    required String username,
  }) {
    return sl<UserRemoteData>().getUserPosts(
      username: username,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<(bool, List<PostEntity>?, String?)> getUserSavedPosts({
    required int page,
    required int limit,
    required String username,
  }) {
    return sl<UserRemoteData>().getUserSavedPosts(
      username: username,
      page: page,
      limit: limit,
    );
  }
}
