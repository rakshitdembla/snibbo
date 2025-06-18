import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/update_post_bloc/update_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/update_post_bloc/update_post_states.dart';
import 'package:snibbo_app/service_locator.dart';

class UpdatePostBloc extends Bloc<UpdatePostEvent, UpdatePostState> {
  UpdatePostBloc() : super(UpdatePostInitial()) {
    on<UpdatePost>((event, emit) async {
      emit(UpdatePostLoading());

      try {
        final userId = await ServicesUtils.getTokenId();

        final (bool success, String? message) = await sl<PostsUsecase>()
            .updatePost(
              postId: event.postId,
              userId: userId!,
              caption: event.caption,
            );

        if (success) {
          emit(
            UpdatePostSuccess(
              title: "Post Updated",
              description:
                  "Your post was updated successfully. Changes will reflect shortly.",
            ),
          );
        } else {
          emit(
            UpdatePostError(
              title: "Update Failed",
              description:
                  message ?? "Unable to update post. Please try again.",
            ),
          );
        }
      } catch (e) {
        emit(
          UpdatePostError(title: "Unexpected Error", description: e.toString()),
        );
      }
    });
  }
}
