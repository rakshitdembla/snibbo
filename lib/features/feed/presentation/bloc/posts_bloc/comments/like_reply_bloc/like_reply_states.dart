import 'package:equatable/equatable.dart';

abstract class LikeReplyState extends Equatable {
  const LikeReplyState();

  @override
  List<Object> get props => [];
}

class LikeReplyInitial extends LikeReplyState {}

class LikeReplyLoading extends LikeReplyState {}

class LikeReplySuccess extends LikeReplyState {
  final String title;
  final String description;

  const LikeReplySuccess({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

class LikeReplyFailure extends LikeReplyState {
  final String title;
  final String description;

  const LikeReplyFailure({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}
