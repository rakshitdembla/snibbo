import 'package:equatable/equatable.dart';

abstract class DeleteCommentState extends Equatable {
  const DeleteCommentState();

  @override
  List<Object> get props => [];
}

class DeleteCommentInitial extends DeleteCommentState {}

class DeleteCommentLoading extends DeleteCommentState {}

class DeleteCommentSuccess extends DeleteCommentState {
  final String title;
  final String description;

  const DeleteCommentSuccess({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

class DeleteCommentFailure extends DeleteCommentState {
  final String title;
  final String description;

  const DeleteCommentFailure({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}
