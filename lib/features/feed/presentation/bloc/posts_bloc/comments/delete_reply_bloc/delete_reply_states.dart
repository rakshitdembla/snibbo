import 'package:equatable/equatable.dart';

abstract class DeleteReplyState extends Equatable {
  const DeleteReplyState();

  @override
  List<Object> get props => [];
}

class DeleteReplyInitial extends DeleteReplyState {}

class DeleteReplyLoading extends DeleteReplyState {}

class DeleteReplySuccess extends DeleteReplyState {
  final String title;
  final String description;

  const DeleteReplySuccess({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

class DeleteReplyFailure extends DeleteReplyState {
  final String title;
  final String description;

  const DeleteReplyFailure({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}
