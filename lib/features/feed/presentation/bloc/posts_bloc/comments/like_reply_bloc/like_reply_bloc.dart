import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_comments_repository.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/like_reply_bloc/like_reply_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/like_reply_bloc/like_reply_states.dart';
import 'package:snibbo_app/service_locator.dart';

class LikeReplyBloc extends Bloc<LikeReplyEvent, LikeReplyState> {
  LikeReplyBloc() : super(LikeReplyInitial()) {
    on<SubmitLikeReplyEvent>((event, emit) async {
      emit(LikeReplyLoading());

      final userId = await ServicesUtils.getTokenId();
      final (success, message) = await sl<PostCommentsRepository>()
          .likeReply(replyId: event.replyId, userId: userId!);

      if (success) {
        emit(LikeReplySuccess(
          title: "Reply liked successfully.",
          description: message.toString(),
        ));
      } else {
        emit(LikeReplyFailure(
          title: "Failed to like reply.",
          description: message.toString(),
        ));
      }
    });
  }
}
