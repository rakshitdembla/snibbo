import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/toogle_like_bloc/toogle_like_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/posts_bloc/toogle_like_bloc/toogle_like_states.dart';
import 'package:snibbo_app/service_locator.dart';

class ToogleLikeBloc extends Bloc<ToogleLikeEvents, ToogleLikeStates> {
   Map<String, bool> likedMap = {};

  ToogleLikeBloc() : super(ToogleLikeInitial()) {
    on<ToogleLike>((event, emit) async {
      final postId = event.postId;

      final alreadyLiked = likedMap[postId] ?? false;

      debugPrint("Triggered ToogleLike Event - AlreadyLiked Status for $postId : $alreadyLiked");

      emit(ToogleLikeLoading());

      if (alreadyLiked && !event.isDislike) {
        emit(ToogleLikeSuccess());
        return;
      } else if (!alreadyLiked && event.isDislike) {
        emit(ToogleLikeSuccess());
        return;
      }

      final userId = await ServicesUtils.getTokenId();

      final (bool success, String? message) = await sl<PostsUsecase>()
          .reactToPost(postId, userId!, event.isDislike);

      if (!success) {
        emit(ToogleLikeError(
          description: message.toString(),
          title: "Failed to react on this post",
        ));
        return;
      }

      emit(ToogleLikeSuccess());
      likedMap[postId] = !event.isDislike;
    });
  }
}
