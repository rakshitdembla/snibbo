import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_comments_repository.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/create_reply_bloc/create_reply_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/create_reply_bloc/create_reply_states.dart';
import 'package:snibbo_app/service_locator.dart';

class CreateReplyBloc extends Bloc<CreateReplyEvent, CreateReplyState> {
  CreateReplyBloc() : super(CreateReplyInitial()) {
    on<SubmitReplyEvent>((event, emit) async {
      emit(CreateReplyLoading(commentId: event.commentId));

      if (event.replyContent.isEmpty) {
      emit(
CreateReplyFailure(
          title: 'Failed to add comment.',
          description: "Comment is empty.",
          commentId: event.commentId,
        )
      )  ;
        return;
      }

      final userId = await ServicesUtils.getTokenId();
      final (success, message) = await sl<PostCommentsRepository>().createReply(
        commentId: event.commentId,
        userId: userId!,
        replyContent: event.replyContent,
      );

      if (success) {
        emit(
          CreateReplySuccess(
            title: "Reply added successfully.",
            description: message.toString(),
            commentId: event.commentId,
          ),
        );
      } else {
        emit(
          CreateReplyFailure(
            title: "Failed to add reply.",
            description: message.toString(),
            commentId: event.commentId,
          ),
        );
      }
    });
  }
}
