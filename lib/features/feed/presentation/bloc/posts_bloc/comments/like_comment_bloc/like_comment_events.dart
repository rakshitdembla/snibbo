import 'package:equatable/equatable.dart';

abstract class LikeCommentEvent extends Equatable {
  const LikeCommentEvent();

  @override
  List<Object> get props => [];
}

class SubmitLikeCommentEvent extends LikeCommentEvent {
  final String commentId;

  const SubmitLikeCommentEvent({required this.commentId});

  @override
  List<Object> get props => [commentId];
}
