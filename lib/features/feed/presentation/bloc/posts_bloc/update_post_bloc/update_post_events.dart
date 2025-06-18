import 'package:equatable/equatable.dart';

abstract class UpdatePostEvent extends Equatable {
  const UpdatePostEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePost extends UpdatePostEvent {
  final String postId;
  final String caption;

  const UpdatePost({required this.postId, required this.caption});

  @override
  List<Object?> get props => [postId, caption];
}
