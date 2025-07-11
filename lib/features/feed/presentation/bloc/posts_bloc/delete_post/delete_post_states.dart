import 'package:equatable/equatable.dart';

abstract class DeletePostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeletePostInitial extends DeletePostState {}

class DeletePostLoading extends DeletePostState {
  final String postId;

  DeletePostLoading({required this.postId});

    @override
  List<Object?> get props => [postId];


}

class DeletePostSuccess extends DeletePostState {
  final String title;
  final String postId;
  final String username;
  final String description;

  DeletePostSuccess({
    required this.title,
    required this.description,
    required this.postId,
    required this.username,
  });

  @override
  List<Object?> get props => [title, description, postId];
}

class DeletePostError extends DeletePostState {
  final String title;
  final String description;
    final String postId;

  DeletePostError({required this.title, required this.description,required this.postId});

  @override
  List<Object?> get props => [title, description,postId];
}
