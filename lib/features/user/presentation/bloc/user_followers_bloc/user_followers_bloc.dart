import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/user/domain/usecases/user_followers_usecase.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_followers_bloc/user_followers_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_followers_bloc/user_followers_states.dart';
import 'package:snibbo_app/service_locator.dart';

class UserFollowersBloc extends Bloc<UserFollowersEvents, UserFollowersStates> {
  int page = 1;
  List<UserEntity> allFollowers = [];
  bool hasMore = true;
  bool isLoading = false;

  UserFollowersBloc() : super(UserFollowersInitial()) {
    on<GetUserFollowers>((event, emit) async {
      emit(UserFollowersLoading(username: event.username));

      // Reset
      page = 1;
      allFollowers = [];
      hasMore = true;
      isLoading = false;

      final userId = await ServicesUtils.getTokenId();
      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<UserFollowersUsecase>().call(
        username: event.username,
        userId: userId!,
        page: page,
        limit: 13,
      );

      if (success && users != null) {
        allFollowers.addAll(users);
        hasMore = users.length == 13;
        page = 2;

        emit(UserFollowersLoaded(users: users,username: event.username));
        return;
      }

      emit(
        UserFollowersError(
          title: "Failed to fetch followers",
          descrition: message.toString(),
          username: event.username
        ),
      );
    });

    on<LoadMoreUserFollowers>((event, emit) async {
      if (isLoading || !hasMore) return;

      isLoading = true;
      final userId = await ServicesUtils.getTokenId();

      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<UserFollowersUsecase>().call(
        username: event.username,
        userId: userId!,
        page: page,
        limit: 13,
      );

      if (success && users != null) {
        allFollowers.addAll(users);
        hasMore = users.length == 13;
        page++;

        isLoading = false;
        emit(UserFollowersPaginationSuccess(users: users,username: event.username));
        return;
      }

      emit(
        UserFollowersPaginationError(
          title: "Failed to load more followers",
          descrition: message.toString(),
          username: event.username
        ),
      );
      isLoading = false;
    });
  }
}
