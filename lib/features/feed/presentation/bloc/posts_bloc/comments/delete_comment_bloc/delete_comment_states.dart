import 'package:equatable/equatable.dart';

abstract class DeleteCommentState extends Equatable {
  const DeleteCommentState();

  @override
  List<Object> get props => [];
}

class DeleteCommentInitial extends DeleteCommentState {}

class DeleteCommentLoading extends DeleteCommentState {
  final String commentId;

  const DeleteCommentLoading({required this.commentId});

  @override
  List<Object> get props => [commentId];
}

class DeleteCommentSuccess extends DeleteCommentState {
  final String title;
  final String description;
  final String commentId;

  const DeleteCommentSuccess({required this.title, required this.description,required this.commentId});

  @override
  List<Object> get props => [title, description,commentId];
}

class DeleteCommentFailure extends DeleteCommentState {
  final String title;
  final String description;
  final String commentId;

  const DeleteCommentFailure({required this.title, required this.description,required this.commentId});

  @override
  List<Object> get props => [title, description];
}
