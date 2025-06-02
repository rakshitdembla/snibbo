import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post_bloc/like_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/like_post_bloc/like_post_states.dart';
import 'package:snibbo_app/service_locator.dart';
import 'package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart';

class LikePostBloc extends Bloc<LikePostEvents, LikePostStates> {
  LikePostBloc() : super(LikePostInitial()) {
    on<LikePostPressed>((event, emit) async {
      emit(LikePostLoading());

      final userId = await ServicesUtils.getTokenId();

      final (success, message) = await sl<PostsUsecase>().likePost(
        postId: event.postId,
        userId: userId!,
      );

      if (success) {
        emit(LikePostSuccess());
      } else {
        emit(LikePostError(
          title: "Like Failed",
          description: message ?? "Something went wrong while liking the post.",
        ));
      }
    });
  }
}
