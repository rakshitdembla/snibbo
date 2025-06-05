import 'package:equatable/equatable.dart';

abstract class LikeReplyEvent extends Equatable {
  const LikeReplyEvent();

  @override
  List<Object> get props => [];
}

class SubmitLikeReplyEvent extends LikeReplyEvent {
  final String replyId;

  const SubmitLikeReplyEvent({required this.replyId});

  @override
  List<Object> get props => [replyId];
}
