import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/save_post/save_post_bloc/save_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/save_post/save_post_bloc/save_post_states.dart';
import 'package:snibbo_app/service_locator.dart';

class SavePostBloc extends Bloc<SavePostEvent, SavePostState> {

SavePostBloc() : super(SavePostInitial()) {
    on<SavePostRequested>((event, emit) async {
      emit(SavePostLoading());
      final userId = await ServicesUtils.getTokenId();

      final (bool success, String? message) = await sl<PostsUsecase>().savePost(
        postId: event.postId,
        userId: userId!,
      );

      if (success) {
        emit(SavePostSuccess(
          title: "Post Saved",
          description: message ?? "Post saved successfully.",
        ));
      } else {
        emit(SavePostError(
          title: "Save Failed",
          description: message ?? "Could not save the post.",
        ));
      }
    });
  }
}
