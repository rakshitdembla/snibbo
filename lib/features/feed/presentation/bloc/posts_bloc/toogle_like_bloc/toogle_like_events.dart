abstract class ToogleLikeEvents {}

class ToogleLike extends ToogleLikeEvents {
  final String postId;
  final bool isDislike;
  ToogleLike({required this.postId,required this.isDislike});
}

