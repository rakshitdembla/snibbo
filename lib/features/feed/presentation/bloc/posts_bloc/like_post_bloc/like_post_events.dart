import 'package:equatable/equatable.dart';

abstract class LikePostEvents extends Equatable {
  const LikePostEvents();
}

class LikePostPressed extends LikePostEvents {
  final String postId;

  const LikePostPressed({required this.postId});

  @override
  List<Object> get props => [postId];
}
