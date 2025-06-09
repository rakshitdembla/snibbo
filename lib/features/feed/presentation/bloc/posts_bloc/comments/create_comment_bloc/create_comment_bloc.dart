import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/repositories/post_comments_repository.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/create_comment_bloc/create_comment_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/comments/create_comment_bloc/create_comment_states.dart';
import 'package:snibbo_app/service_locator.dart';

class CreateCommentBloc extends Bloc<CreateCommentEvent, CreateCommentState> {
  CreateCommentBloc() : super(CreateCommentInitial()) {
    on<SubmitCommentEvent>((event, emit) async {
      emit(CreateCommentLoading(postId: event.postId));

      if (event.commentContent.isEmpty) {
    emit(
 CreateCommentFailure(
            title: 'Failed to add comment.',
            description: "Comment is empty.",
            postId: event.postId
          )
    ) ;  
          return;
      }

      final userId = await ServicesUtils.getTokenId();
      final (success, message) = await sl<PostCommentsRepository>()
          .createComment(
            postId: event.postId,
            userId: userId!,
            commentContent: event.commentContent,
          );

      if (success) {
        emit(
          CreateCommentSuccess(
            title: 'Comment added successfully.',
            description: message.toString(),
            postId: event.postId
          ),
        );
      } else {
        emit(
          CreateCommentFailure(
            title: 'Failed to add comment.',
            description: message.toString(),
            postId: event.postId
          ),
        );
      }
    });
  }
}
