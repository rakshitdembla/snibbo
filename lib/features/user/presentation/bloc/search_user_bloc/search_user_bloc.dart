import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/user/presentation/bloc/search_user_bloc/search_user_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/search_user_bloc/search_user_states.dart';
import 'package:snibbo_app/service_locator.dart';
import 'package:snibbo_app/features/user/domain/usecases/search_user_usecase.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  SearchUserBloc() : super(SearchUserInitial()) {
    on<SearchUserByUsername>((event, emit) async {
      final trimmedUsername = event.username.trim().toLowerCase();
      final userId = await ServicesUtils.getTokenId();

      if (trimmedUsername.isEmpty) {
        emit(
          const SearchUserEmptyState(
            title: "Empty Search",
            description: "Please enter a username to search.",
          ),
        );
        return;
      }

      emit(SearchUserLoading());

      final (success, user, _) = await sl<SearchUserUsecase>().call(
        username: trimmedUsername,
        userId: userId!,
      );

      if (success && user != null) {
        emit(SearchUserFound(user));
      } else {
        emit(SearchUserNotFound());
      }
    });

    on<ResetSearch>((event, emit) {
      emit(SearchUserInitial());
    });
  }
}
