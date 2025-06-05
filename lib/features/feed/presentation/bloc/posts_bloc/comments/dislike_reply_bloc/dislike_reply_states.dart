import 'package:equatable/equatable.dart';

abstract class DislikeReplyState extends Equatable {
  const DislikeReplyState();

  @override
  List<Object> get props => [];
}

class DislikeReplyInitial extends DislikeReplyState {}

class DislikeReplyLoading extends DislikeReplyState {}

class DislikeReplySuccess extends DislikeReplyState {
  final String title;
  final String description;

  const DislikeReplySuccess({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

class DislikeReplyFailure extends DislikeReplyState {
  final String title;
  final String description;

  const DislikeReplyFailure({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}
