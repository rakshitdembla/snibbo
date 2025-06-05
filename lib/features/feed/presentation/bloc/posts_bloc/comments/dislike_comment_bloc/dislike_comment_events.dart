import 'package:equatable/equatable.dart';

abstract class DislikeCommentEvent extends Equatable {
  const DislikeCommentEvent();

  @override
  List<Object> get props => [];
}

class SubmitDislikeCommentEvent extends DislikeCommentEvent {
  final String commentId;

  const SubmitDislikeCommentEvent({required this.commentId});

  @override
  List<Object> get props => [commentId];
}
