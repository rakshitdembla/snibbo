import 'package:equatable/equatable.dart';

abstract class CreateCommentState extends Equatable {
  const CreateCommentState();

  @override
  List<Object> get props => [];
}

class CreateCommentInitial extends CreateCommentState {}

class CreateCommentLoading extends CreateCommentState {
  final String postId;

  const CreateCommentLoading({required this.postId});

  @override
  List<Object> get props => [postId];
}

class CreateCommentSuccess extends CreateCommentState {
  final String title;
  final String description;
  final String postId;

  const CreateCommentSuccess({
    required this.description,
    required this.title,
    required this.postId,
  });

  @override
  List<Object> get props => [title, description, postId];
}

class CreateCommentFailure extends CreateCommentState {
  final String title;
  final String description;
  final String postId;

  const CreateCommentFailure({
    required this.description,
    required this.title,
    required this.postId,
  });

  @override
  List<Object> get props => [title, description, postId];
}
