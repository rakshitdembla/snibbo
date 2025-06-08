import 'package:equatable/equatable.dart';

abstract class ToggleCommentLikeEvent extends Equatable {
  const ToggleCommentLikeEvent();

  @override
  List<Object> get props => [];
}

class SubmitToggleCommentLikeEvent extends ToggleCommentLikeEvent {
  final String commentId;
  final bool isDislike;

  const SubmitToggleCommentLikeEvent({
    required this.commentId,
    required this.isDislike,
  });

  @override
  List<Object> get props => [commentId, isDislike];
}
