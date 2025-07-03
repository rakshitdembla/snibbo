import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

abstract class GetSinglePostState {}

class GetSinglePostInitialState extends GetSinglePostState {}

class GetSinglePostLoadingState extends GetSinglePostState {}

class GetSinglePostSuccessState extends GetSinglePostState {
  final PostEntity postEntity;

  GetSinglePostSuccessState({required this.postEntity});
}

class GetSinglePostErrorState extends GetSinglePostState {
  final String title;
  final String description;

  GetSinglePostErrorState({required this.title, required this.description});
}
