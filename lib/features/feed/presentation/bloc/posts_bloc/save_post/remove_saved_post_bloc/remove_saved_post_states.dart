import 'package:equatable/equatable.dart';

abstract class RemoveSavedPostState extends Equatable {
  @override
  List<Object> get props => [];
}

class RemoveSavedPostInitial extends RemoveSavedPostState {}

class RemoveSavedPostLoading extends RemoveSavedPostState {}

class RemoveSavedPostSuccess extends RemoveSavedPostState {
  final String title;
  final String description;

  RemoveSavedPostSuccess({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

class RemoveSavedPostError extends RemoveSavedPostState {
  final String title;
  final String description;

  RemoveSavedPostError({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}
