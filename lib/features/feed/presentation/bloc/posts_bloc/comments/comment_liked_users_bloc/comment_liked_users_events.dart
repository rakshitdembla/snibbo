import 'package:equatable/equatable.dart';

abstract class CommentLikedUsersEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCommentLikedUsers extends CommentLikedUsersEvents {
  final String commentId;

  GetCommentLikedUsers({required this.commentId});

  @override
  List<Object> get props => [commentId];
}

class LoadMoreCommentLikedUsers extends CommentLikedUsersEvents {
  final String commentId;

  LoadMoreCommentLikedUsers({required this.commentId});

  @override
  List<Object> get props => [commentId];
}
