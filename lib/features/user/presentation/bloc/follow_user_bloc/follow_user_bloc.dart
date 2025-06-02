import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/user/domain/usecases/follow_usecase.dart';
import 'package:snibbo_app/features/user/presentation/bloc/follow_user_bloc/follow_user_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/follow_user_bloc/follow_user_states.dart';

class FollowUserBloc extends Bloc<FollowUserEvents, FollowUserStates> {
  FollowUserBloc() : super(FollowUserInitial()) {
    on<FollowRequested>((event, emit) async {
      emit(FollowUserLoading());
      final userId = await ServicesUtils.getTokenId();
      final (bool success, String? message) = await FollowUsecase().call(
        userId: userId!,
        username: event.username,
      );

      if (success) {
        emit(
          FollowUserSuccess(
            description: message.toString(),
            title: 'User followed successfully.',
          ),
        );
      } else {
        emit(
          FollowUserError(
            title: "Follow Failed",
            description: message ?? "Unknown error occurred",
          ),
        );
      }
    });
  }
}
