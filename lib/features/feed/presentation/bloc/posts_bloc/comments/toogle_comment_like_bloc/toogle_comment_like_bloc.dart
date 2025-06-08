import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_comments_repository.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/toogle_comment_like_bloc/toogle_comment_like_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/toogle_comment_like_bloc/toogle_comment_like_states.dart';
import 'package:snibbo_app/service_locator.dart';

class ToggleCommentLikeBloc extends Bloc<ToggleCommentLikeEvent, ToggleCommentLikeState> {
  ToggleCommentLikeBloc() : super(ToggleCommentLikeInitial()) {
    on<SubmitToggleCommentLikeEvent>((event, emit) async {

      emit(ToogleCommentLikeLoading(commentId: event.commentId));

      final userId = await ServicesUtils.getTokenId();
      final (success, message) = event.isDislike
          ? await sl<PostCommentsRepository>().dislikeComment(
              commentId: event.commentId, 
              userId: userId!)
          : await sl<PostCommentsRepository>().likeComment(
              commentId: event.commentId, 
              userId: userId!);

      if (success) {
        emit(ToggleCommentLikeSuccess(
          title: event.isDislike 
              ? "Comment disliked successfully."
              : "Comment liked successfully.",
          description: message.toString(),
          commentId: event.commentId,
        ));
      } else {
        emit(ToggleCommentLikeFailure(
          title: event.isDislike
              ? "Failed to dislike comment."
              : "Failed to like comment.",
          description: message.toString(),
          commentId: event.commentId,
        ));
      }
    });
  }
}