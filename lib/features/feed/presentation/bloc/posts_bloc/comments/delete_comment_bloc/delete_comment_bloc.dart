import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_comments_repository.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/delete_comment_bloc/delete_comment_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/delete_comment_bloc/delete_comment_states.dart';
import 'package:snibbo_app/service_locator.dart';

class DeleteCommentBloc extends Bloc<DeleteCommentEvent, DeleteCommentState> {
  DeleteCommentBloc() : super(DeleteCommentInitial()) {
    on<SubmitDeleteCommentEvent>((event, emit) async {
      emit(DeleteCommentLoading(commentId: event.commentId));

      final userId = await ServicesUtils.getTokenId();
      final (success, message) = await sl<PostCommentsRepository>()
          .deleteComment(commentId: event.commentId, userId: userId!);

      if (success) {
        emit(DeleteCommentSuccess(
          title: 'Comment deleted successfully.',
          description: message.toString(),
          commentId: event.commentId
        ));
      } else {
        emit(DeleteCommentFailure(
          title: 'Failed to delete comment.',
          description: message.toString(),
          commentId: event.commentId
        ));
      }
    });
  }
}
