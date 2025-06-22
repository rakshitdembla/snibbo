import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/chats/domain/use_cases/block_user_usecase.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/unblock_user_bloc/unblock_user_events.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/unblock_user_bloc/unblock_user_states.dart';
import 'package:snibbo_app/service_locator.dart';

class BlockUserBloc extends Bloc<BlockUserEvents, BlockUserStates> {
  BlockUserBloc() : super(BlockUserInitial()) {
    on<BlockUserPressed>((event, emit) async {
      emit(BlockUserLoading());

      final tokenId = await ServicesUtils.getTokenId();

      final (success, message) = await sl<BlockUserUseCase>().call(
        tokenId: tokenId!,
        username: event.username,
      );

      if (success) {
        emit(BlockUserSuccess());
      } else {
        emit(BlockUserError(
          title: "Block Failed",
          description: message ?? "Something went wrong while blocking the user.",
        ));
      }
    });
  }
}
