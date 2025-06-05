import 'package:equatable/equatable.dart';

abstract class CreateCommentState extends Equatable {
  const CreateCommentState();

  @override
  List<Object> get props => [];
}

class CreateCommentInitial extends CreateCommentState {}

class CreateCommentLoading extends CreateCommentState {}

class CreateCommentSuccess extends CreateCommentState {
  final String title;
  final String description;

  const CreateCommentSuccess({required this.description, required this.title});

  @override
  List<Object> get props => [title, description];
}

class CreateCommentFailure extends CreateCommentState {
  final String title;
  final String description;

  const CreateCommentFailure({required this.description, required this.title});

  @override
  List<Object> get props => [title, description];
}
