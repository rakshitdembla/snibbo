import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/user/domain/usecases/user_followings_usecase.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_followings_bloc/user_followings_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_followings_bloc/user_followings_states.dart';
import 'package:snibbo_app/service_locator.dart';

class UserFollowingsBloc
    extends Bloc<UserFollowingsEvents, UserFollowingsStates> {
  int page = 1;
  List<UserEntity> allFollowings = [];
  bool hasMore = true;
  bool isLoading = false;

  UserFollowingsBloc()
    : super(UserFollowingsInitial()) {
    on<GetUserFollowings>((event, emit) async {
      emit(UserFollowingsLoading(username: event.username));

      //Reset all

      page = 1;
      allFollowings = [];
      hasMore = true;
      isLoading = false;

      final userId = await ServicesUtils.getTokenId();
      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<UserFollowingsUsecase>().call(
        username: event.username,
        userId: userId!,
        page: page,
        limit: 10,
      );

      if (success && users != null) {
        allFollowings.addAll(users);
        hasMore = users.length == 10;
        page = 2;

        emit(UserFollowingsLoaded(users: users,username: event.username));
        return;
      }

      emit(
        UserFollowingsError(
          title: "Failed to fetch followings",
          descrition: message.toString(),
          username: event.username
        ),
      );
    });

    on<LoadMoreUserFollowings>((event, emit) async {
      if (isLoading || !hasMore) return;

      isLoading = true;
      final userId = await ServicesUtils.getTokenId();

      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<UserFollowingsUsecase>().call(
        username: event.username,
        userId: userId!,
        page: page,
        limit: 10,
      );

      if (success && users != null) {
        allFollowings.addAll(users);
        hasMore = users.length == 10;
        page++;

        isLoading = false;
        emit(UserFollowingsPaginationSuccess(users: users,username: event.username));
        return;
      }

      emit(
        UserFollowingsPaginationError(
          title: "Failed to load more followings",
          descrition: message.toString(),
          username: event.username
        ),
      );
      isLoading = false;
    });
  }
}
