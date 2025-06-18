import 'package:equatable/equatable.dart';

abstract class DeletePostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeletePostInitial extends DeletePostState {}

class DeletePostLoading extends DeletePostState {}

class DeletePostSuccess extends DeletePostState {
  final String title;
  final String description;

  DeletePostSuccess({required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}

class DeletePostError extends DeletePostState {
  final String title;
  final String description;

  DeletePostError({required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}
