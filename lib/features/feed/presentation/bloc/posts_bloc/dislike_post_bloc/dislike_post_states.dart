import 'package:equatable/equatable.dart';

abstract class DislikePostStates extends Equatable {
  const DislikePostStates();

  @override
  List<Object?> get props => [];
}

class DislikePostInitial extends DislikePostStates {}

class DislikePostLoading extends DislikePostStates {}

class DislikePostSuccess extends DislikePostStates {}

class DislikePostError extends DislikePostStates {
  final String title;
  final String description;

  const DislikePostError({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}
