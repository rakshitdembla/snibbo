import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_comments_repository.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/delete_reply_bloc/delete_reply_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/delete_reply_bloc/delete_reply_states.dart';
import 'package:snibbo_app/service_locator.dart';

class DeleteReplyBloc extends Bloc<DeleteReplyEvent, DeleteReplyState> {
  DeleteReplyBloc() : super(DeleteReplyInitial()) {
    on<SubmitDeleteReplyEvent>((event, emit) async {
      emit(DeleteReplyLoading(replyId: event.replyId));

      final userId = await ServicesUtils.getTokenId();
      final (success, message) = await sl<PostCommentsRepository>().deleteReply(
        replyId: event.replyId,
        userId: userId!,
      );

      if (success) {
        emit(
          DeleteReplySuccess(
            title: 'Reply deleted successfully.',
            description: message.toString(),
            replyId: event.replyId
          ),
        );
      } else {
        emit(
          DeleteReplyFailure(
            title: 'Failed to delete reply.',
            description: message.toString(),
            replyId: event.replyId
          ),
        );
      }
    });
  }
}
