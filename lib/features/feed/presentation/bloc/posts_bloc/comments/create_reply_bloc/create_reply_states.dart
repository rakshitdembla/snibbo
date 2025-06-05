import 'package:equatable/equatable.dart';

abstract class CreateReplyState extends Equatable {
  const CreateReplyState();

  @override
  List<Object> get props => [];
}

class CreateReplyInitial extends CreateReplyState {}

class CreateReplyLoading extends CreateReplyState {}

class CreateReplySuccess extends CreateReplyState {
  final String title;
  final String description;

  const CreateReplySuccess({required this.description, required this.title});

  @override
  List<Object> get props => [title, description];
}

class CreateReplyFailure extends CreateReplyState {
  final String title;
  final String description;

  const CreateReplyFailure({required this.description, required this.title});

  @override
  List<Object> get props => [title, description];
}
