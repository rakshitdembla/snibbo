import 'package:equatable/equatable.dart';

abstract class GetCommentRepliesEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCommentReplies extends GetCommentRepliesEvents {
  final String commentId;

  FetchCommentReplies({required this.commentId});

  @override
  List<Object> get props => [commentId];
}

class ResetCommentsReplies extends GetCommentRepliesEvents{
  
}

