import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart';

abstract class CreateReplyState extends Equatable {
  const CreateReplyState();

  @override
  List<Object> get props => [];
}

class CreateReplyInitial extends CreateReplyState {}

class CreateReplyLoading extends CreateReplyState {
  final String commentId;

  const CreateReplyLoading({required this.commentId});
  @override
  List<Object> get props => [commentId];
}

class CreateReplySuccess extends CreateReplyState {
  final String title;
  final String description;
  final String commentId;
  final CommentReplyEntity reply;

  const CreateReplySuccess({
    required this.description,
    required this.title,
    required this.commentId,
    required this.reply
  });

  @override
  List<Object> get props => [title, description, commentId];
}

class CreateReplyFailure extends CreateReplyState {
  final String title;
  final String description;
  final String commentId;

  const CreateReplyFailure({
    required this.description,
    required this.title,
    required this.commentId,
  });

  @override
  List<Object> get props => [title, description];
}
