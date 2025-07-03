import 'package:bloc/bloc.dart';
import 'package:snibbo_app/core/local_data_manager/story_views_manager.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/user/domain/usecases/search_following_usecase.dart';
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
  String? userId;
  bool isSearchMode = false;

  UserFollowingsBloc() : super(UserFollowingsInitial()) {
    on<GetUserFollowings>((event, emit) async {
      //Reset all
      page = 1;
      allFollowings = [];
      hasMore = true;
      isLoading = false;
      isSearchMode = false;

      event.showLoading
          ? emit(UserFollowingsLoading(username: event.username))
          : null;

       userId = await ServicesUtils.getTokenId();
      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<UserFollowingsUsecase>().call(
        username: event.username,
        userId: userId!,
        page: page,
        limit: 13,
      );

      if (success && users != null) {
        allFollowings.addAll(users);
        hasMore = users.length == 13;
        page = 2;
        StoryViewsManager.clearStoriesByUsers(users: users);

        emit(UserFollowingsLoaded(users: users, username: event.username));
        return;
      }

      emit(
        UserFollowingsError(
          title: "Failed to fetch followings",
          descrition: message.toString(),
          username: event.username,
        ),
      );
    });

    on<LoadMoreUserFollowings>((event, emit) async {
      if (isLoading || !hasMore || isSearchMode) return;

      isLoading = true;
            if (userId == null) {
        return;
      }


      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<UserFollowingsUsecase>().call(
        username: event.username,
        userId: userId!,
        page: page,
        limit: 13,
      );

      if (success && users != null) {
        allFollowings.addAll(users);
        hasMore = users.length == 13;
        page++;
        StoryViewsManager.clearStoriesByUsers(users: users);

        isLoading = false;
        emit(
          UserFollowingsPaginationSuccess(
            users: users,
            username: event.username,
          ),
        );
        return;
      }

      emit(
        UserFollowingsPaginationError(
          title: "Failed to load more followings",
          descrition: message.toString(),
          username: event.username,
        ),
      );
      isLoading = false;
    });

    on<SearchFollowing>((event, emit) async {
      allFollowings = [];
      userId = userId ?? await ServicesUtils.getTokenId();

      isSearchMode = true;

      final (
        bool success,
        List<UserEntity>? users,
        String? message,
      ) = await sl<SearchFollowingUsecase>().call(
        username: event.username,
        userId: userId!,
        userToSearch: event.userToSearch,
      );

      allFollowings = users ?? [];
      StoryViewsManager.clearStoriesByUsers(users: users ?? []);

      emit(UserFollowingsLoaded(users: users ?? [], username: event.username));
    });
  }
}
