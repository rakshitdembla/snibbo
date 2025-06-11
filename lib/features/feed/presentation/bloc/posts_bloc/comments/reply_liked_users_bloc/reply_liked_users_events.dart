import 'package:equatable/equatable.dart';

abstract class ReplyLikedUsersEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetReplyLikedUsers extends ReplyLikedUsersEvents {
  final String replyId;

  GetReplyLikedUsers({required this.replyId});

  @override
  List<Object> get props => [replyId];
}

class LoadMoreReplyLikedUsers extends ReplyLikedUsersEvents {
  final String replyId;

  LoadMoreReplyLikedUsers({required this.replyId});

  @override
  List<Object> get props => [replyId];
}
