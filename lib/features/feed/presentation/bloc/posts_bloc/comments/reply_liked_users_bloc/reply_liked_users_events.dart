import 'package:equatable/equatable.dart';

abstract class ReplyLikedUsersEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetReplyLikedUsers extends ReplyLikedUsersEvents {
  final String replyId;
  final bool showloading;

  GetReplyLikedUsers({required this.replyId, required this.showloading});

  @override
  List<Object> get props => [replyId];
}

class LoadMoreReplyLikedUsers extends ReplyLikedUsersEvents {
  final String replyId;

  LoadMoreReplyLikedUsers({required this.replyId});

  @override
  List<Object> get props => [replyId];
}

class SearchReplyLikedUser extends ReplyLikedUsersEvents {
  final String replyId;
  final String userToSearch;

  SearchReplyLikedUser({required this.replyId, required this.userToSearch});

  @override
  List<Object> get props => [replyId, userToSearch];
}
