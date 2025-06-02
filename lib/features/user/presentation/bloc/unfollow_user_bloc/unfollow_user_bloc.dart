import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/user/domain/usecases/unfollow_usecase.dart';
import 'package:snibbo_app/features/user/presentation/bloc/unfollow_user_bloc/unfollow_user_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/unfollow_user_bloc/unfollow_user_states.dart';

class UnfollowUserBloc extends Bloc<UnfollowUserEvents, UnfollowUserStates> {
  UnfollowUserBloc() : super(UnfollowUserInitial()) {
    on<UnfollowRequested>((event, emit) async {
      emit(UnfollowUserLoading());

      final userId = await ServicesUtils.getTokenId();

      final (bool success, String? message) = await UnfollowUsecase().call(
        userId: userId!,
        username: event.username,
      );

      if (success) {
        emit(
          UnfollowUserSuccess(
            title: 'User unfollowed successfully.',
            description: message.toString(),
          ),
        );
      } else {
        emit(
          UnfollowUserError(
            title: "Unfollow Failed",
            description: message ?? "Unknown error occurred",
          ),
        );
      }
    });
  }
}
