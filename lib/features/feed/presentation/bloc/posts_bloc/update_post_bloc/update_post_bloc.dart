import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/update_post_bloc/update_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/update_post_bloc/update_post_states.dart';
import 'package:snibbo_app/core/local_data_manager/profile/user_posts_helper.dart';
import 'package:snibbo_app/core/local_data_manager/profile/user_saved_posts_helper.dart';
import 'package:snibbo_app/service_locator.dart';

class UpdatePostBloc extends Bloc<UpdatePostEvent, UpdatePostState> {
  UpdatePostBloc() : super(UpdatePostInitial()) {
    on<UpdatePost>((event, emit) async {
      emit(UpdatePostLoading(postId: event.postId));

      try {
        final userId = await ServicesUtils.getTokenId();

        final (bool success, String? message) = await sl<PostsUsecase>()
            .updatePost(
              postId: event.postId,
              userId: userId!,
              caption: event.caption,
            );

        if (success) {
          final userPostsList = UserPostsHelper.posts[event.username];
          final userPostIndex = userPostsList?.indexWhere(
            (post) => post.id == event.postId,
          );
          if (userPostsList != null &&
              userPostIndex != null &&
              userPostIndex != -1) {
            userPostsList[userPostIndex].postCaption = event.caption.trim();
          }

          final savedPostsList = UserSavedPostsHelper.posts[event.username];
          final savedPostIndex = savedPostsList?.indexWhere(
            (post) => post.id == event.postId,
          );
          if (savedPostsList != null &&
              savedPostIndex != null &&
              savedPostIndex != -1) {
            savedPostsList[savedPostIndex].postCaption = event.caption.trim();
          }

          emit(
            UpdatePostSuccess(
              postId: event.postId,
              username: event.username,
              updatedCaptions: event.caption.trim(),
              title: "Post Updated",
              description:
                  "Your post was updated successfully.",
            ),
          );
        } else {
          emit(
            UpdatePostError(
              title: "Update Failed",
              postId: event.postId,
              description:
                  message ?? "Unable to update post. Please try again.",
            ),
          );
        }
      } catch (e) {
        emit(
          UpdatePostError(title: "Unexpected Error", description: e.toString(),postId: event.postId),
        );
      }
    });
  }
}
