import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/usecases/stories_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/story_viewers_bloc/story_viewers_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/stories_bloc/story_viewers_bloc/story_viewers_states.dart';
import 'package:snibbo_app/service_locator.dart';

class StoryViewersBloc extends Bloc<StoryViewersEvents, StoryViewersStates> {
  StoryViewersBloc() : super(StoryViewersInitialState()) {
    on<GetStoryViewers>((event, emit) async {
      emit(StoryViewersLoadingState());
      final userId = await ServicesUtils.getTokenId();
      debugPrint(userId);
      final (success, users, message) = await sl<StoriesUsecase>().storyViewers(
        userId: userId!,
        storyId: event.storyId,
      );

      if (success && users != null) {
        emit(
          StoryViewersSuccessState(
            title: "Fetched StoryViewers Successfully.",
            description: message.toString(),
            users: users,
          ),
        );
        return;
      }
      emit(
        StoryViewersErrorState(
          description: message.toString(),
          title: "Failed to get story viewers",
        ),
      );
    });
  }
}
