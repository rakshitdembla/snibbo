abstract class SavePostAnimationEvents {}

class TapSavePost extends SavePostAnimationEvents {
  final String postId;
  TapSavePost({required this.postId});
}

class TapUnsavePost extends SavePostAnimationEvents {
  final String postId;
  TapUnsavePost({required this.postId});
}
