import 'package:equatable/equatable.dart';

abstract class PostLikedUsersEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPostLikedUsers extends PostLikedUsersEvents {
  final String postId;

  GetPostLikedUsers({required this.postId});

  @override
  List<Object> get props => [postId];
}

class LoadMorePostLikedUsers extends PostLikedUsersEvents {
  final String postId;

  LoadMorePostLikedUsers({required this.postId});

  @override
  List<Object> get props => [postId];
}
