import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/local_data_manager/post_interaction_manager.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/deep_link_view/domain/usecases/get_single_post_usecase.dart';
import 'package:snibbo_app/features/deep_link_view/presentation/bloc/get_single_post_events.dart';
import 'package:snibbo_app/features/deep_link_view/presentation/bloc/get_single_post_states.dart';
import 'package:snibbo_app/service_locator.dart';

class GetSinglePostBloc extends Bloc<GetSinglePostEvent, GetSinglePostState> {
  GetSinglePostBloc() : super(GetSinglePostInitialState()) {
    on<GetSinglePostData>((event, emit) async {
      emit(GetSinglePostLoadingState());

      final tokenId = await ServicesUtils.getTokenId();

      final (
        success,
        post,
        message,
      ) = await sl<GetSinglePostUsecase>().getSinglePostById(
        tokenId: tokenId!,
        postId: event.postId,
      );

      if (success && post != null) {
        PostInteractionManager.clearPosts(posts: [post]);
        emit(GetSinglePostSuccessState(postEntity: post));
      } else {
        emit(
          GetSinglePostErrorState(
            title: "Failed to Load Post",
            description: message ?? "Unknown error occurred.",
          ),
        );
      }
    });
  }
}
