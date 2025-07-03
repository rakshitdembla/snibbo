abstract class GetSinglePostEvent {}

class GetSinglePostData extends GetSinglePostEvent {
  final String postId;

  GetSinglePostData({required this.postId});
}
