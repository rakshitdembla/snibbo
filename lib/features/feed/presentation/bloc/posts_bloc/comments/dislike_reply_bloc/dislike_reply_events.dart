import 'package:equatable/equatable.dart';

abstract class DislikeReplyEvent extends Equatable {
  const DislikeReplyEvent();

  @override
  List<Object> get props => [];
}

class SubmitDislikeReplyEvent extends DislikeReplyEvent {
  final String replyId;

  const SubmitDislikeReplyEvent({required this.replyId});

  @override
  List<Object> get props => [replyId];
}
