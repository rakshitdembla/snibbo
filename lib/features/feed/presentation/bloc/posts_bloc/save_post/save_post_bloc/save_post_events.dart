import 'package:equatable/equatable.dart';

abstract class SavePostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SavePostRequested extends SavePostEvent {
  final String postId;

  SavePostRequested({required this.postId});

  @override
  List<Object> get props => [postId];
}
