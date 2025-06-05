import 'package:equatable/equatable.dart';

abstract class LikeCommentState extends Equatable {
  const LikeCommentState();

  @override
  List<Object> get props => [];
}

class LikeCommentInitial extends LikeCommentState {}

class LikeCommentLoading extends LikeCommentState {}

class LikeCommentSuccess extends LikeCommentState {
  final String title;
  final String description;

  const LikeCommentSuccess({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

class LikeCommentFailure extends LikeCommentState {
  final String title;
  final String description;

  const LikeCommentFailure({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}
