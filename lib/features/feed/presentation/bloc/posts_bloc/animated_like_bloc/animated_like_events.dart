abstract class AnimatedLikeEvents {}

class DoubleTapLike extends AnimatedLikeEvents{
  final String postId;

  DoubleTapLike({required this.postId});
}

class RemoveShownLike extends AnimatedLikeEvents{
  final String postId;

  RemoveShownLike({required this.postId});
}