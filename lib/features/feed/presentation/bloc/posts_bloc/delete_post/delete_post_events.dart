import 'package:equatable/equatable.dart';

abstract class DeletePostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeletePost extends DeletePostEvent {
  final String postId;

  DeletePost({required this.postId,});

  @override
  List<Object?> get props => [postId,];
}
