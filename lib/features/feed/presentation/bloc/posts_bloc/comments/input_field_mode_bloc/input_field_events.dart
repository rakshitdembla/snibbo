import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

abstract class InputFieldEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ShowCommentField extends InputFieldEvent {
  final PostEntity post;

  ShowCommentField({required this.post});

  @override
  List<Object> get props => [post];
}

class ShowReplyField extends InputFieldEvent {
  final PostCommentEntity comment;

  ShowReplyField({required this.comment,});

  @override
  List<Object> get props => [comment];
}
