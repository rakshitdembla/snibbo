import 'package:equatable/equatable.dart';

abstract class DeletePostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeletePost extends DeletePostEvent {
  final String postId;
  final String username;

  DeletePost({required this.postId,required this.username});

  @override
  List<Object?> get props => [postId,username];
}
