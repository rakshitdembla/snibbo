import 'package:equatable/equatable.dart';

abstract class DeleteCommentEvent extends Equatable {
  const DeleteCommentEvent();

  @override
  List<Object> get props => [];
}

class SubmitDeleteCommentEvent extends DeleteCommentEvent {
  final String commentId;

  const SubmitDeleteCommentEvent({required this.commentId});

  @override
  List<Object> get props => [commentId];
}
