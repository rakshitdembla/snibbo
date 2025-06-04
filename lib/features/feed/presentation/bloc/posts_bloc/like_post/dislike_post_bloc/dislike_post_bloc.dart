import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/dislike_post_bloc/dislike_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post/dislike_post_bloc/dislike_post_states.dart';
import 'package:snibbo_app/service_locator.dart';
import 'package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart';

class DislikePostBloc extends Bloc<DislikePostEvents, DislikePostStates> {
  DislikePostBloc() : super(DislikePostInitial()) {
    on<DislikePostPressed>((event, emit) async {
      emit(DislikePostLoading());

      final userId = await ServicesUtils.getTokenId();

      final (success, message) = await sl<PostsUsecase>().disLike(
        postId: event.postId,
        userId: userId!,
      );

      if (success) {
        emit(DislikePostSuccess());
      } else {
        emit(DislikePostError(
          title: "Dislike Failed",
          description: message ?? "Something went wrong while disliking the post.",
        ));
      }
    });
  }
}
