import 'package:equatable/equatable.dart';

abstract class UpdatePostState extends Equatable {
  const UpdatePostState();

  @override
  List<Object?> get props => [];
}

class UpdatePostInitial extends UpdatePostState {}

class UpdatePostLoading extends UpdatePostState {
  final String postId;

  const UpdatePostLoading({required this.postId});
}

class UpdatePostSuccess extends UpdatePostState {
  final String title;
  final String description;
  final String postId;
  final String username;
  final String updatedCaptions;

  const UpdatePostSuccess({
    required this.title,
    required this.description,
    required this.postId,
    required this.username,
    required this.updatedCaptions,
  });

  @override
  List<Object?> get props => [title, description,postId,username,updatedCaptions];
}

class UpdatePostError extends UpdatePostState {
  final String title;
  final String description;
  final String postId;

  const UpdatePostError({required this.title, required this.description,required this.postId});

  @override
  List<Object?> get props => [title, description];
}
