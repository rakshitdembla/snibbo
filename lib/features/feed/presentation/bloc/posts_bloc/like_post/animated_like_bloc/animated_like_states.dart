abstract class AnimatedLikeStates {}

class AnimatedLikeInitial extends AnimatedLikeStates{}

class ShowLikeState extends AnimatedLikeStates {
  final String postId;

  ShowLikeState({required this.postId});
}

class HideLikeState extends AnimatedLikeStates {
  final String postid;

  HideLikeState({required this.postid});
}
