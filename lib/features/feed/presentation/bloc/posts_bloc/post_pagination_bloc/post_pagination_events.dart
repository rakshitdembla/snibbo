import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

abstract class PostPaginationEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMorePosts extends PostPaginationEvents {}

class InitializePaginationPosts extends PostPaginationEvents {
  final List<PostEntity> initialPosts;

  InitializePaginationPosts({required this.initialPosts});
}

class UpdateFeedPost extends PostPaginationEvents {
  final String postId;
  final String updatedCaptions;

  UpdateFeedPost({required this.postId, required this.updatedCaptions});

  @override
  List<Object> get props => [postId, updatedCaptions];
}

class DeleteFeedPost extends PostPaginationEvents {
  final String postId;

  DeleteFeedPost({required this.postId});

  @override
  List<Object> get props => [postId];
}
