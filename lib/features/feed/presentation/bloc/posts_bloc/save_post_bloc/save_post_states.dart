import 'package:equatable/equatable.dart';

abstract class SavePostState extends Equatable {
  @override
  List<Object> get props => [];
}

class SavePostInitial extends SavePostState {}

class SavePostLoading extends SavePostState {}

class SavePostSuccess extends SavePostState {
  final String title;
  final String description;

  SavePostSuccess({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

class SavePostError extends SavePostState {
  final String title;
  final String description;

  SavePostError({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}
