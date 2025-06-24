import 'package:equatable/equatable.dart';

abstract class PostLikedUsersEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPostLikedUsers extends PostLikedUsersEvents {
  final String postId;
  final bool showloading;

  GetPostLikedUsers({required this.postId,required this.showloading});

  @override
  List<Object> get props => [postId];
}

class LoadMorePostLikedUsers extends PostLikedUsersEvents {
  final String postId;

  LoadMorePostLikedUsers({required this.postId});

  @override
  List<Object> get props => [postId];
}

class SearchUser extends PostLikedUsersEvents {
  final String postId;
  final String userToSearch;

  SearchUser({required this.postId,required this.userToSearch});

  @override
  List<Object> get props => [postId,userToSearch];
}
