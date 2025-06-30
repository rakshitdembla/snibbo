import 'package:equatable/equatable.dart';

abstract class UpdatePostEvent extends Equatable {
  const UpdatePostEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePost extends UpdatePostEvent {
  final String postId;
  final String caption;
  final String username;

  const UpdatePost({required this.postId, required this.caption,required this.username});

  @override
  List<Object?> get props => [postId, caption,username];
}
