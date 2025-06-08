import 'package:equatable/equatable.dart';

abstract class ToggleReplyLikeEvent extends Equatable {
  const ToggleReplyLikeEvent();

  @override
  List<Object> get props => [];
}

class SubmitToggleReplyLikeEvent extends ToggleReplyLikeEvent {
  final String replyId;
  final bool isDislike;

  const SubmitToggleReplyLikeEvent({
    required this.replyId,
    required this.isDislike,
  });

  @override
  List<Object> get props => [replyId, isDislike];
}

