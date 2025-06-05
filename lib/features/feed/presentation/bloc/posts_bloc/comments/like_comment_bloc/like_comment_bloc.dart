import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_comments_repository.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/like_comment_bloc/like_comment_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/like_comment_bloc/like_comment_states.dart';
import 'package:snibbo_app/service_locator.dart';

class LikeCommentBloc extends Bloc<LikeCommentEvent, LikeCommentState> {
  LikeCommentBloc() : super(LikeCommentInitial()) {
    on<SubmitLikeCommentEvent>((event, emit) async {
      emit(LikeCommentLoading());

      final userId = await ServicesUtils.getTokenId();
      final (success, message) = await sl<PostCommentsRepository>()
          .likeComment(commentId: event.commentId, userId: userId!);

      if (success) {
        emit(LikeCommentSuccess(
          title: "Comment liked successfully.",
          description: message.toString(),
        ));
      } else {
        emit(LikeCommentFailure(
          title: "Failed to like comment.",
          description: message.toString(),
        ));
      }
    });
  }
}
