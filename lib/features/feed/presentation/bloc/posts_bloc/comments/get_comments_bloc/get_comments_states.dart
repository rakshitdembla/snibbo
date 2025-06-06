import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';

abstract class GetPostCommentsStates extends Equatable {
  const GetPostCommentsStates();

  @override
  List<Object?> get props => [];
}

class GetPostCommentsInitial extends GetPostCommentsStates {}

class GetPostCommentsLoaded extends GetPostCommentsStates {
  final List<PostCommentEntity> comments;

  const GetPostCommentsLoaded({required this.comments});

  @override
  List<Object?> get props => [comments];
}

class GetPostCommentsPaginationSuccess extends GetPostCommentsStates {
  final List<PostCommentEntity> comments;

  const GetPostCommentsPaginationSuccess({required this.comments});

  @override
  List<Object?> get props => [comments];
}

class GetPostCommentsError extends GetPostCommentsStates {
  final String title;
  final String description;

  const GetPostCommentsError({required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}

class GetPostCommentsPaginationError extends GetPostCommentsStates {
  final String title;
  final String description;

  const GetPostCommentsPaginationError({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}
