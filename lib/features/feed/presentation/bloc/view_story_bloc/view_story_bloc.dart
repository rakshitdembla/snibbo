import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/usecases/stories_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/view_story_bloc/view_story_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/view_story_bloc/view_story_states.dart';
import 'package:snibbo_app/service_locator.dart';

class ViewStoryBloc extends Bloc<ViewStoryEvents, ViewStoryStates> {
  ViewStoryBloc() : super(ViewStoryInitialState()) {
    on<ViewStory>((event, emit) async {
      debugPrint("adding view to this story");
      emit(ViewStoryLoadingState());

      final userId = await ServicesUtils.getTokenId();

      final (success, message) = await sl<StoriesUsecase>().viewStory(
        userId: userId!,
        storyId: event.storyId,
      );

      if (success) {
        debugPrint("view added successfully");
        emit(
          ViewStorySuccessState(
            title: "Story view added successfully.",
            description: message.toString(),
          ),
        );
        return;
      }

      emit(
        ViewStoryErrorState(
          description: message.toString(),
          title: "Unable to add view to this story.",
        ),
      );
    });
  }
}