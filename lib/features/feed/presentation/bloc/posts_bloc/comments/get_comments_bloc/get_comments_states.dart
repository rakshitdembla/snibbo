import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';

abstract class GetPostCommentsStates extends Equatable {
  const GetPostCommentsStates();

  @override
  List<Object?> get props => [];
}

class GetPostCommentsInitial extends GetPostCommentsStates {}

class GetPostCommentsLoading extends GetPostCommentsStates {
  final String postId;

  const GetPostCommentsLoading({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class GetPostCommentsLoaded extends GetPostCommentsStates {
  final List<PostCommentEntity> comments;
  final String postId;

  const GetPostCommentsLoaded({required this.comments, required this.postId});

  @override
  List<Object?> get props => [comments, postId];
}

class GetPostCommentsError extends GetPostCommentsStates {
  final String title;
  final String description;
  final String postId;

  const GetPostCommentsError({
    required this.title,
    required this.description,
    required this.postId,
  });

  @override
  List<Object?> get props => [title, description, postId];
}

class GetPostCommentsPaginationError extends GetPostCommentsStates {
  final String title;
  final String description;
  final String postId;

  const GetPostCommentsPaginationError({
    required this.title,
    required this.description,
    required this.postId,
  });

  @override
  List<Object?> get props => [title, description, postId];
}

class CommentsUpdated extends GetPostCommentsStates {
  final String postId;
    final List<PostCommentEntity> comments;

  const CommentsUpdated({required this.postId,required this.comments});

  @override
  List<Object?> get props => [postId,comments];
}
