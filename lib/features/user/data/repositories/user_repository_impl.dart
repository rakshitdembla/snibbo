import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
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
    required String userId,
  }) {
    return sl<UserRemoteData>().getUserPosts(
      username: username,
      page: page,
      limit: limit,
      userId: userId,
    );
  }

  @override
  Future<(bool, List<PostEntity>?, String?)> getUserSavedPosts({
    required int page,
    required int limit,
    required String username,
    required String userId,
  }) {
    return sl<UserRemoteData>().getUserSavedPosts(
      username: username,
      page: page,
      limit: limit,
      userId: userId,
    );
  }

  @override
  Future<(bool, List<UserEntity>?, String?)> getUserFollowers({
    required String username,
    required String userId,
    required int page,
    required int limit,
  }) {
    return sl<UserRemoteData>().getUserFollowers(
      username: username,
      userId: userId,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<(bool, List<UserEntity>?, String?)> getUserFollowing({
    required String username,
    required String userId,
    required int page,
    required int limit,
  }) {
    return sl<UserRemoteData>().getUserFollowing(
      username: username,
      userId: userId,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<(bool, UserEntity?, String?)> searchUserByUsername({
    required String username,
  }) {
    return sl<UserRemoteData>().searchUserByUsername(username: username);
  }
}
