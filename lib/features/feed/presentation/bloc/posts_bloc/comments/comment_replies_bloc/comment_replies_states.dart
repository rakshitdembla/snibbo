import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart';

abstract class GetCommentRepliesStates extends Equatable {
  const GetCommentRepliesStates();

  @override
  List<Object?> get props => [];
}

class GetCommentRepliesInitial extends GetCommentRepliesStates {}

class GetCommentRepliesLoaded extends GetCommentRepliesStates {
  final List<CommentReplyEntity> replies;

  const GetCommentRepliesLoaded({required this.replies});

  @override
  List<Object?> get props => [replies];
}

class GetCommentRepliesPaginationSuccess extends GetCommentRepliesStates {
  final List<CommentReplyEntity> replies;

  const GetCommentRepliesPaginationSuccess({required this.replies});

  @override
  List<Object?> get props => [replies];
}

class GetCommentRepliesError extends GetCommentRepliesStates {
  final String title;
  final String description;

  const GetCommentRepliesError({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}

class GetCommentRepliesPaginationError extends GetCommentRepliesStates {
  final String title;
  final String description;

  const GetCommentRepliesPaginationError({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}
