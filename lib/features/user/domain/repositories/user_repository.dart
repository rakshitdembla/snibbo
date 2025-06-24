import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
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

  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getUserPosts({
    required int page,
    required int limit,
    required String username,
    required String userId,
  });

  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getUserSavedPosts({
    required int page,
    required int limit,
    required String username,
    required String userId,
  });

  Future<(bool success, List<UserEntity>? users, String? message)>
  getUserFollowers({
    required String username,
    required String userId,
    required int page,
    required int limit,
  });

  Future<(bool success, List<UserEntity>? users, String? message)>
  getUserFollowing({
    required String username,
    required String userId,
    required int page,
    required int limit,
  });

  Future<(bool success, List<UserEntity>? users, String? message)>
  searchUserByUsername({required String username,required String userId});

  Future<(bool success, List<UserEntity>? users, String? message)>
  searchFollower({
    required String username,
    required String userId,
    required String userToSearch,
  });

  Future<(bool success, List<UserEntity>? users, String? message)>
  searchFollowing({
    required String username,
    required String userId,
    required String userToSearch,
  });
}
