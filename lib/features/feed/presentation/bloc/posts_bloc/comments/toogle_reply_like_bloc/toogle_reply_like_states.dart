import 'package:equatable/equatable.dart';

abstract class ToggleReplyLikeState extends Equatable {
  const ToggleReplyLikeState();

  @override
  List<Object> get props => [];
}

class ToggleReplyLikeInitial extends ToggleReplyLikeState {}

class ToggleReplyLikeLoading extends ToggleReplyLikeState {
  final String replyId;

  const ToggleReplyLikeLoading({required this.replyId});

  @override
  List<Object> get props => [replyId];
}

class ToggleReplyLikeSuccess extends ToggleReplyLikeState {
  final String title;
  final String description;
  final String replyId;

  const ToggleReplyLikeSuccess({
    required this.title,
    required this.description,
    required this.replyId,
  });

  @override
  List<Object> get props => [title, description, replyId];
}

class ToggleReplyLikeFailure extends ToggleReplyLikeState {
  final String title;
  final String description;
  final String replyId;

  const ToggleReplyLikeFailure({
    required this.title,
    required this.description,
    required this.replyId,
  });

  @override
  List<Object> get props => [title, description, replyId];
}

