import 'package:equatable/equatable.dart';

abstract class DeleteReplyEvent extends Equatable {
  const DeleteReplyEvent();

  @override
  List<Object> get props => [];
}

class SubmitDeleteReplyEvent extends DeleteReplyEvent {
  final String replyId;

  const SubmitDeleteReplyEvent({required this.replyId});

  @override
  List<Object> get props => [replyId];
}
