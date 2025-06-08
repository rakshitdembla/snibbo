import 'package:equatable/equatable.dart';

abstract class ToggleCommentLikeState extends Equatable {
  const ToggleCommentLikeState();

  @override
  List<Object> get props => [];
}

class ToggleCommentLikeInitial extends ToggleCommentLikeState {}


class ToogleCommentLikeLoading extends ToggleCommentLikeState  {
  final String commentId;

 const ToogleCommentLikeLoading({required this.commentId});

  @override
  List<Object> get props => [commentId];


}

class ToggleCommentLikeSuccess extends ToggleCommentLikeState {
  final String title;
  final String description;
  final String commentId;

  const ToggleCommentLikeSuccess({
    required this.title,
    required this.description,
    required this.commentId,
  });

  @override
  List<Object> get props => [title, description, commentId];
}

class ToggleCommentLikeFailure extends ToggleCommentLikeState {
  final String title;
  final String description;
  final String commentId;

  const ToggleCommentLikeFailure({
    required this.title,
    required this.description,
    required this.commentId,
  });

  @override
  List<Object> get props => [title, description, commentId];
}