import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';

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
  final PostCommentEntity comment;

  const CreateCommentSuccess({
    required this.description,
    required this.title,
    required this.comment,
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
