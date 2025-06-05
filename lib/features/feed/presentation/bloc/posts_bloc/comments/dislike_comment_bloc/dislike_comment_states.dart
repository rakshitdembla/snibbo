import 'package:equatable/equatable.dart';

abstract class DislikeCommentState extends Equatable {
  const DislikeCommentState();

  @override
  List<Object> get props => [];
}

class DislikeCommentInitial extends DislikeCommentState {}

class DislikeCommentLoading extends DislikeCommentState {}

class DislikeCommentSuccess extends DislikeCommentState {
  final String title;
  final String description;

  const DislikeCommentSuccess({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

class DislikeCommentFailure extends DislikeCommentState {
  final String title;
  final String description;

  const DislikeCommentFailure({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}
