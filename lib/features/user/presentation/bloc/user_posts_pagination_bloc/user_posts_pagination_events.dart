import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

abstract class UserPostsPaginationEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMoreUserPosts extends UserPostsPaginationEvents {
  final String username;

  LoadMoreUserPosts({required this.username});

  @override
  List<Object?> get props => [username];
}

class InitializeUserPosts extends UserPostsPaginationEvents {
  final List<PostEntity> initialPosts;
  final String username;

  InitializeUserPosts({required this.initialPosts, required this.username});

  @override
  List<Object?> get props => [initialPosts];
}

class UpdateUserPost extends UserPostsPaginationEvents {
  final String postId;
  final String updatedCaptions;
  final String username;

  UpdateUserPost({required this.postId, required this.username,required this.updatedCaptions});

  @override
  List<Object?> get props => [postId,username,updatedCaptions];
}


class DeleteUserPost extends UserPostsPaginationEvents {
  final String postId;
  final String username;

  DeleteUserPost({required this.postId, required this.username});

  @override
  List<Object?> get props => [postId,username];
}
