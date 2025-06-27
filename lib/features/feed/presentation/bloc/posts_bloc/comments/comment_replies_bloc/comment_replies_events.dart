import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart';

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

class ResetCommentsReplies extends GetCommentRepliesEvents {}

class AddNewCommentReply extends GetCommentRepliesEvents {
  final String commentId;
  final CommentReplyEntity reply;
  AddNewCommentReply({required this.commentId, required this.reply});

  @override
  List<Object> get props => [commentId, reply];
}
