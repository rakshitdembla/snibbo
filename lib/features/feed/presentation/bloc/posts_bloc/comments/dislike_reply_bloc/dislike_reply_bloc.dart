import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_comments_repository.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/dislike_reply_bloc/dislike_reply_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/dislike_reply_bloc/dislike_reply_states.dart';
import 'package:snibbo_app/service_locator.dart';

class DislikeReplyBloc extends Bloc<DislikeReplyEvent, DislikeReplyState> {
  DislikeReplyBloc() : super(DislikeReplyInitial()) {
    on<SubmitDislikeReplyEvent>((event, emit) async {
      emit(DislikeReplyLoading());

      final userId = await ServicesUtils.getTokenId();
      final (success, message) = await sl<PostCommentsRepository>()
          .dislikeReply(replyId: event.replyId, userId: userId!);

      if (success) {
        emit(DislikeReplySuccess(
          title: "Reply dislike successful.",
          description: message.toString(),
        ));
      } else {
        emit(DislikeReplyFailure(
          title: "Failed to dislike reply.",
          description: message.toString(),
        ));
      }
    });
  }
}
