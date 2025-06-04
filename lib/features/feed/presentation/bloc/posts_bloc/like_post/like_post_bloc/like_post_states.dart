import 'package:equatable/equatable.dart';

abstract class LikePostStates extends Equatable {
  const LikePostStates();

  @override
  List<Object?> get props => [];
}

class LikePostInitial extends LikePostStates {}

class LikePostLoading extends LikePostStates {}

class LikePostSuccess extends LikePostStates {}

class LikePostError extends LikePostStates {
  final String title;
  final String description;

  const LikePostError({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}
