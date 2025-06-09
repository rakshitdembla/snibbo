import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';

abstract class InputFieldState extends Equatable {
  @override
  List<Object> get props => [];
}

class CommentFieldState extends InputFieldState {

}

class ReplyFieldState extends InputFieldState {
  final PostCommentEntity comment;

  ReplyFieldState({required this.comment,});

  @override
  List<Object> get props => [comment,];
}
