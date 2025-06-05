import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_comments_repository.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/dislike_comment_bloc/dislike_comment_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/dislike_comment_bloc/dislike_comment_states.dart';
import 'package:snibbo_app/service_locator.dart';

class DislikeCommentBloc extends Bloc<DislikeCommentEvent, DislikeCommentState> {
  DislikeCommentBloc() : super(DislikeCommentInitial()) {
    on<SubmitDislikeCommentEvent>((event, emit) async {
      emit(DislikeCommentLoading());

      final userId = await ServicesUtils.getTokenId();
      final (success, message) = await sl<PostCommentsRepository>()
          .dislikeComment(commentId: event.commentId, userId: userId!);

      if (success) {
        emit(DislikeCommentSuccess(
          title: "Comment disliked successfully.",
          description: message.toString(),
        ));
      } else {
        emit(DislikeCommentFailure(
          title: "Failed to dislike comment.",
          description: message.toString(),
        ));
      }
    });
  }
}
