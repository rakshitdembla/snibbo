import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/local_data_manager/story_views_manager.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';
import 'package:snibbo_app/features/user/domain/usecases/get_user_posts_usecase.dart';
import 'package:snibbo_app/features/user/domain/usecases/get_user_saved_posts.dart';
import 'package:snibbo_app/features/user/domain/usecases/user_profile_usecase.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_profile_bloc/user_profile_events.dart';
import 'package:snibbo_app/features/user/presentation/bloc/user_profile_bloc/user_profile_states.dart';
import 'package:snibbo_app/service_locator.dart';

class UserProfileBloc extends Bloc<UserProfileEvents, UserProfileStates> {
  UserProfileBloc() : super(UserProfileInitial()) {
    on<GetUserProfile>((event, emit) async {
      emit(UserProfileLoading(username: event.username));
      final userId = await ServicesUtils.getTokenId();

      //@ --- Get User Profile Details ---
      final (
        bool profileSuccess,
        ProfileEntity? profileEntity,
        String? profileMessage,
      ) = await sl<UserProfileUsecase>().getUserProfile(
        username: event.username,
        userId: userId!,
      );
      //@ --- Get User Posts ---
      final (
        bool userPostsSuccess,
        List<PostEntity>? userPosts,
        String? userPostsMessage,
      ) = await sl<GetUserPostsUsecase>().call(
        page: 1,
        limit: 15,
        username: event.username,
        userId: userId,
      );

      //@ --- Get User Saved Posts ---
      final (
        bool userSavedPostsSuccess,
        List<PostEntity>? userSavedPosts,
        String? userSavedPostsMessage,
      ) = await sl<GetUserSavedPostsUsecase>().call(
        page: 1,
        limit: 15,
        username: event.username,
        userId: userId,
      );

      final myUsername = await ServicesUtils.getUsername();

      if (profileSuccess &&
          userPostsSuccess &&
          userSavedPostsSuccess &&
          profileEntity != null &&
          userPosts != null &&
          userSavedPosts != null) {
            StoryViewsManager.clearStoryByProfile(profile: profileEntity);
        emit(
          UserProfileSuccess(
            isMyProfile: profileEntity.username == myUsername,
            profileEntity: profileEntity,
            userPosts: userPosts,
            userSavedPosts: userSavedPosts,
            username: event.username
          ),
        );
        return;
      }

      emit(
        UserProfileError(
          description: "Oops! something went wrong",
          title: "Failed to load user profile",
          username: event.username
        ),
      );
    });
  }
}
