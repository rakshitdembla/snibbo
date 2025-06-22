import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/chats/domain/use_cases/unblock_user_usecase.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/block_user_bloc/block_user_events.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/block_user_bloc/block_user_states.dart';
import 'package:snibbo_app/service_locator.dart';

class UnblockUserBloc extends Bloc<UnblockUserEvents, UnblockUserStates> {
  UnblockUserBloc() : super(UnblockUserInitial()) {
    on<UnblockUserPressed>((event, emit) async {
      emit(UnblockUserLoading());

      final tokenId = await ServicesUtils.getTokenId();

      final (success, message) = await sl<UnblockUserUseCase>().call(
        tokenId: tokenId!,
        username: event.username,
      );

      if (success) {
        emit(UnblockUserSuccess());
      } else {
        emit(
          UnblockUserError(
            title: "Unblock Failed",
            description:
                message ?? "Something went wrong while unblocking the user.",
          ),
        );
      }
    });
  }
}
