import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

abstract class PostPaginationStates {}

class PostPaginationInitial extends PostPaginationStates {}


class PostPaginationLoaded extends PostPaginationStates {
  final List<PostEntity> postLists;


  PostPaginationLoaded({required this.postLists});
}

class PostPaginationError extends PostPaginationStates {
  final String title;
  final String description;
  
  PostPaginationError({required this.title, required this.description});
}

class RefreshFeedPosts extends PostPaginationStates{}