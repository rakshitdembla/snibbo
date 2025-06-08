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
  final String commentId;

  const GetCommentRepliesLoaded({
    required this.replies,
    required this.commentId,
  });

  @override
  List<Object?> get props => [replies, commentId];
}

class GetCommentRepliesError extends GetCommentRepliesStates {
  final String title;
  final String description;
  final String commentId;

  const GetCommentRepliesError({
    required this.title,
    required this.description,
    required this.commentId,
  });

  @override
  List<Object?> get props => [title, description, commentId];
}

