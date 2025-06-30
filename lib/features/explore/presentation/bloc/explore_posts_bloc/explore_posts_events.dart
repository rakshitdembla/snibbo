import 'package:equatable/equatable.dart';

abstract class ExplorePostsEvents extends Equatable {
    @override
  List<Object?> get props => [];
}

class GetPosts extends ExplorePostsEvents{
}

class LoadMoreExplorePosts extends ExplorePostsEvents{
}

class UpdateExplorePost extends ExplorePostsEvents {
  final String postId;
  final String updatedCaptions;

  UpdateExplorePost({
    required this.postId,
    required this.updatedCaptions,
  });

  @override
  List<Object?> get props => [postId, updatedCaptions];
}

class DeleteExplorePost extends ExplorePostsEvents {
  final String postId;

  DeleteExplorePost({required this.postId});

  @override
  List<Object?> get props => [postId];
}
