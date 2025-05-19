import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/features/feed/domain/usecases/stories_usecase.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_user_stories_bloc/get_user_stories_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/get_user_stories_bloc/get_user_stories_states.dart';
import 'package:snibbo_app/service_locator.dart';

class GetUserStoriesBloc extends Bloc<UserStoriesEvents, UserStoriesStates> {
  GetUserStoriesBloc() : super(UserStoriesInitialState()) {
    on<GetUserStories>((event, emit) async {
      debugPrint("Bloc : Event Triggered GetUserStories");
      emit(UserStoriesLoadingState());
      debugPrint("Bloc : Emit Loading State");
      final (success, userStories, message) = await sl<StoriesUsecase>()
          .getUserStories(event.username);

      if (success && userStories != null) {
        emit(UserStoriesSuccessState(userStories: userStories));
        debugPrint("Bloc : Emit Success State");
        return;
      }

      emit(
        UserStoriesErrorState(
          description: message ?? "An unknown error occurred.",
          title: "This story's acting shy today.",
        ),
      );
      debugPrint("Bloc : Emit Error State");
    });
  }
}
