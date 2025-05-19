import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/usecases/stories_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/delete_story_bloc/delete_story_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/delete_story_bloc/delete_story_states.dart';
import 'package:snibbo_app/service_locator.dart';

class DeleteStoryBloc extends Bloc<DeleteStoryEvents, DeleteStoryStates> {
  DeleteStoryBloc() : super(DeleteStoryInitialState()) {
    on<DeleteStory>((event, emit) async {
      emit(DeleteStoryLoadingState());

      final userId = await ServicesUtils.getTokenId();

      final (success, message) = await sl<StoriesUsecase>().deleteStory(
        userId: userId!,
        storyId: event.storyId,
      );

      if (success) {
        emit(
          DeleteStorySuccessState(
            title: "Story removed",
            description: message.toString(),
          ),
        );
        return;
      }

      emit(
        DeleteStoryErrorState(
          description: message.toString(),
          title: "Unable to delete story",
        ),
      );
    });
  }
}
