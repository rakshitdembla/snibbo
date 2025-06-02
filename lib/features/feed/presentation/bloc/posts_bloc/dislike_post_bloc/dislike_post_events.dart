import 'package:equatable/equatable.dart';

abstract class DislikePostEvents extends Equatable {
  const DislikePostEvents();
}

class DislikePostPressed extends DislikePostEvents {
  final String postId;

  const DislikePostPressed({required this.postId});

  @override
  List<Object> get props => [postId];
}
