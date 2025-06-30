import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/delete_post/delete_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/delete_post/delete_post_states.dart';
import 'package:snibbo_app/service_locator.dart';

class DeletePostBloc extends Bloc<DeletePostEvent, DeletePostState> {
  DeletePostBloc() : super(DeletePostInitial()) {
    on<DeletePost>((event, emit) async {
      emit(DeletePostLoading());

      final userId = await ServicesUtils.getTokenId();
      final (success, message) = await sl<PostsUsecase>().deletePost(
        postId: event.postId,
        userId: userId!,
      );

      if (success) {
        emit(
          DeletePostSuccess(
            postId: event.postId,
            username: event.username,
            title: "Post Deleted",
            description: message ?? "Your post has been deleted successfully.",
          ),
        );
      } else {
        emit(
          DeletePostError(
            title: "Deletion Failed",
            description:
                message ?? "Could not delete the post. Try again later.",
          ),
        );
      }
    });
  }
}
