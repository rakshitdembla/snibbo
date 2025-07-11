import 'package:equatable/equatable.dart';

abstract class DeleteReplyState extends Equatable {
  const DeleteReplyState();

  @override
  List<Object> get props => [];
}

class DeleteReplyInitial extends DeleteReplyState {}

class DeleteReplyLoading extends DeleteReplyState {
  final String replyId;

  const DeleteReplyLoading({required this.replyId});

  @override
  List<Object> get props => [replyId];
}

class DeleteReplySuccess extends DeleteReplyState {
  final String title;
  final String description;
  final String replyId;

  const DeleteReplySuccess({
    required this.title,
    required this.description,
    required this.replyId,
  });

  @override
  List<Object> get props => [title, description, replyId];
}

class DeleteReplyFailure extends DeleteReplyState {
  final String title;
  final String description;
  final String replyId;

  const DeleteReplyFailure({
    required this.title,
    required this.description,
    required this.replyId,
  });

  @override
  List<Object> get props => [title, description, replyId];
}
