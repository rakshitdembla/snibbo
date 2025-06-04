abstract class AnimatedLikeEvents {}

class DoubleTapLike extends AnimatedLikeEvents{
  final String postId;

  DoubleTapLike({required this.postId});
}

class TappedDislike extends AnimatedLikeEvents{
  final String postId;

  TappedDislike({
    required this.postId
  });
}