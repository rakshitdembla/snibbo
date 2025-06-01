import 'dart:io';

abstract class CreatePostStates {}

class CreatePostInitial extends CreatePostStates {}

class CreatePostLoading extends CreatePostStates {}

class CreatePostError extends CreatePostStates {
  final String title;
  final String description;

  CreatePostError({required this.title, required this.description});
}

class CreatePostSuccess extends CreatePostStates {
  final String title;
  final String description;
  CreatePostSuccess({required this.description, required this.title});
}

class PickingPostImage extends CreatePostStates {}

class PickPostImageError extends CreatePostStates {
  final String title;
  final String description;
  PickPostImageError({required this.description, required this.title});
}

class PickedPostImage extends CreatePostStates {
  final File file;
  PickedPostImage({required this.file});
}
