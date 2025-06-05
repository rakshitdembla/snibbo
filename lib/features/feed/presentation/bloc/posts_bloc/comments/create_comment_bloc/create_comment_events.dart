import 'package:equatable/equatable.dart';

abstract class CreateCommentEvent extends Equatable {
  const CreateCommentEvent();

  @override
  List<Object> get props => [];
}

class SubmitCommentEvent extends CreateCommentEvent {
  final String postId;
  final String commentContent;

  const SubmitCommentEvent({
    required this.postId,
    required this.commentContent,
  });

  @override
  List<Object> get props => [postId,commentContent];
}
