import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';

abstract class GetPostCommentsEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPostComments extends GetPostCommentsEvents {
  final String postId;

  FetchPostComments({required this.postId});

  @override
  List<Object> get props => [postId];
}

class LoadMorePostComments extends GetPostCommentsEvents {
  final String postId;

  LoadMorePostComments({required this.postId});

  @override
  List<Object> get props => [postId];
}

class AddNewPostComment extends GetPostCommentsEvents {
  final String postId;
  final PostCommentEntity comment;
  AddNewPostComment({required this.comment, required this.postId});

  @override
  List<Object> get props => [postId, comment];
}

class DeletePostComment extends GetPostCommentsEvents {
  final String postId;
  final String commentId;
  DeletePostComment({required this.commentId, required this.postId});

  @override
  List<Object> get props => [postId, commentId];
}

class RefreshComments extends GetPostCommentsEvents {
  final String postId;
  RefreshComments({required this.postId});
}
