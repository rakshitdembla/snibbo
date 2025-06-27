import 'package:equatable/equatable.dart';

abstract class CreateReplyEvent extends Equatable {
  const CreateReplyEvent();

  @override
  List<Object> get props => [];
}

class SubmitReplyEvent extends CreateReplyEvent {
  final String commentId;
  final String replyContent;

  const SubmitReplyEvent({
    required this.commentId,
    required this.replyContent,
  });

  @override
  List<Object> get props => [commentId, replyContent];
}

