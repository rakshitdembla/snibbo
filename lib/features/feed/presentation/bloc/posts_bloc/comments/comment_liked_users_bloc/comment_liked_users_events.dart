import 'package:equatable/equatable.dart';

abstract class CommentLikedUsersEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCommentLikedUsers extends CommentLikedUsersEvents {
  final String commentId;
  final bool showloading;

  GetCommentLikedUsers({required this.commentId, required this.showloading});

  @override
  List<Object> get props => [commentId, showloading];
}

class LoadMoreCommentLikedUsers extends CommentLikedUsersEvents {
  final String commentId;

  LoadMoreCommentLikedUsers({required this.commentId});

  @override
  List<Object> get props => [commentId];
}

class SearchCommentLikedUser extends CommentLikedUsersEvents {
  final String commentId;
  final String userToSearch;

  SearchCommentLikedUser({required this.commentId, required this.userToSearch});

  @override
  List<Object> get props => [commentId, userToSearch];
}

