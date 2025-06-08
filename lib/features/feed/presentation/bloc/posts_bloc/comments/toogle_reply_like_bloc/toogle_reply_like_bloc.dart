import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_comments_repository.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/toogle_reply_like_bloc/toogle_reply_like_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/toogle_reply_like_bloc/toogle_reply_like_states.dart';
import 'package:snibbo_app/service_locator.dart';

class ToggleReplyLikeBloc extends Bloc<ToggleReplyLikeEvent, ToggleReplyLikeState> {
  ToggleReplyLikeBloc() : super(ToggleReplyLikeInitial()) {
    on<SubmitToggleReplyLikeEvent>((event, emit) async {
      emit(ToggleReplyLikeLoading(replyId: event.replyId));

      final userId = await ServicesUtils.getTokenId();
      final (success, message) = event.isDislike
          ? await sl<PostCommentsRepository>().dislikeReply(
              replyId: event.replyId,
              userId: userId!,
            )
          : await sl<PostCommentsRepository>().likeReply(
              replyId: event.replyId,
              userId: userId!,
            );

      if (success) {
        emit(ToggleReplyLikeSuccess(
          title: event.isDislike ? "Reply disliked successfully." : "Reply liked successfully.",
          description: message.toString(),
          replyId: event.replyId,
        ));
      } else {
        emit(ToggleReplyLikeFailure(
          title: event.isDislike ? "Failed to dislike reply." : "Failed to like reply.",
          description: message.toString(),
          replyId: event.replyId,
        ));
      }
    });
  }
}

