import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/save_post/remove_saved_post_bloc/remove_saved_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/save_post/remove_saved_post_bloc/remove_saved_post_states.dart';
import 'package:snibbo_app/service_locator.dart';

class RemoveSavedPostBloc
    extends Bloc<RemoveSavedPostEvent, RemoveSavedPostState> {
  RemoveSavedPostBloc() : super(RemoveSavedPostInitial()) {
    on<RemoveSavedPostRequested>((event, emit) async {
      emit(RemoveSavedPostLoading());
      final userId = await ServicesUtils.getTokenId();

      final (bool success, String? message) = await sl<PostsUsecase>()
          .removeSavedPost(postId: event.postId, userId: userId!);

      if (success) {
        emit(
          RemoveSavedPostSuccess(
            title: "Removed",
            description: message ?? "Post removed from saved successfully.",
          ),
        );
      } else {
        emit(
          RemoveSavedPostError(
            title: "Remove Failed",
            description: message ?? "Could not remove the saved post.",
          ),
        );
      }
    });
  }
}
