import 'package:snibbo_app/features/feed/data/data_sources/remote/post_actions_remote_data.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_interactions_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class PostInteractionsRepositoryImpl extends PostInteractionsRepository {
  @override
  Future<(bool success, List<UserEntity>? users, String? message)>
  getPostLikedUsers({
    required String postId,
    required String userId,
    required int page,
    required int limit,
  }) {
    return sl<PostActionsRemoteData>().getPostLikedUsers(
      postId: postId,
      userId: userId,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<(bool, String?)> removeSavedPost({
    required String postId,
    required String userId,
  }) {
    return sl<PostActionsRemoteData>().removeSavedPost(
      postId: postId,
      userId: userId,
    );
  }

  @override
  Future<(bool, String?)> savePost({
    required String postId,
    required String userId,
  }) {
    return sl<PostActionsRemoteData>().savePost(postId: postId, userId: userId);
  }

  @override
  Future<(bool, String?)> disLikepost({
    required String postId,
    required String userId,
  }) {
    return sl<PostActionsRemoteData>().dislikePost(postId, userId);
  }

  @override
  Future<(bool, String?)> likePost({
    required String postId,
    required String userId,
  }) {
    return sl<PostActionsRemoteData>().likePost(postId, userId);
  }

  @override
  Future<(bool, String?)> updatePost({
    required String postId,
    required String userId,
    required String caption,
  }) {
    return sl<PostActionsRemoteData>().updatePost(
      postId: postId,
      userId: userId,
      caption: caption,
    );
  }

  @override
  Future<(bool success, String? message)> deletePost({
    required String postId,
    required String userId,
  }) {
    return sl<PostActionsRemoteData>().deletePost(
      postId: postId,
      userId: userId,
    );
  }

  @override
  Future<(bool, List<UserEntity>?, String?)> searchPostLikedUser({
    required String userId,
    required String userToSearch,
    required String postId,
  }) {
    return sl<PostActionsRemoteData>().searchPostLikedUser(
      userId: userId,
      userToSearch: userToSearch,
      postId: postId,
    );
  }
}
