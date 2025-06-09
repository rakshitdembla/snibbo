import 'package:equatable/equatable.dart';

abstract class CreateReplyState extends Equatable {
  const CreateReplyState();

  @override
  List<Object> get props => [];
}

class CreateReplyInitial extends CreateReplyState {}

class CreateReplyLoading extends CreateReplyState {
  final String commentId;

  const CreateReplyLoading({required this.commentId});
  @override
  List<Object> get props => [commentId];
}

class CreateReplySuccess extends CreateReplyState {
  final String title;
  final String description;
  final String commentId;

  const CreateReplySuccess({
    required this.description,
    required this.title,
    required this.commentId,
  });

  @override
  List<Object> get props => [title, description, commentId];
}

class CreateReplyFailure extends CreateReplyState {
  final String title;
  final String description;
  final String commentId;

  const CreateReplyFailure({
    required this.description,
    required this.title,
    required this.commentId,
  });

  @override
  List<Object> get props => [title, description];
}
