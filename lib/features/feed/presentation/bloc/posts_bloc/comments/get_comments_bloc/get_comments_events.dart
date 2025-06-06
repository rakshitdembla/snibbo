import 'package:equatable/equatable.dart';

abstract class GetPostCommentsEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPostComments extends GetPostCommentsEvents {
  final String postId;

  FetchPostComments({required this.postId});

  @override
  List<Object> get props => [postId];
}

class LoadMorePostComments extends GetPostCommentsEvents {
  final String postId;

  LoadMorePostComments({required this.postId});

  @override
  List<Object> get props => [postId];
}
