abstract class SavePostAnimationStates {}

class SavePostAnimationInitial extends SavePostAnimationStates {}

class ShowSaveAnimationState extends SavePostAnimationStates {
  final String postId;
  ShowSaveAnimationState({required this.postId});
}

class HideSaveAnimationState extends SavePostAnimationStates {
  final String postId;
  HideSaveAnimationState({required this.postId});
}
