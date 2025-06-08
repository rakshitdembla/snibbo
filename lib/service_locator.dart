import "package:get_it/get_it.dart";
import "package:image_picker/image_picker.dart";
import "package:snibbo_app/core/network/base_api/api_services.dart";
import "package:snibbo_app/features/auth/data/data_sources/remote/auth_remote_data.dart";
import "package:snibbo_app/features/auth/data/repositories/auth_repository_impl.dart";
import "package:snibbo_app/features/auth/domain/repositories/auth_repository.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:snibbo_app/features/auth/domain/usecases/forget_password_usecase.dart";
import "package:snibbo_app/features/auth/domain/usecases/login_usecase.dart";
import "package:snibbo_app/features/auth/domain/usecases/register_usecase.dart";
import "package:snibbo_app/features/create/data/data_sources/remote/content_creator_remote_data.dart";
import "package:snibbo_app/features/create/data/repositories/content_creator_repository_impl.dart";
import "package:snibbo_app/features/create/domain/repositories/content_creator_repository.dart";
import "package:snibbo_app/features/create/domain/usecases/create_post_usecase.dart";
import "package:snibbo_app/features/create/domain/usecases/create_story_usecase.dart";
import "package:snibbo_app/features/create/domain/usecases/upload_image_usecase.dart";
import "package:snibbo_app/features/explore/data/data_sources/remote/explore_remote_data.dart";
import "package:snibbo_app/features/explore/data/repositories/explore_repositories_impl.dart";
import "package:snibbo_app/features/explore/domain/repositories/explore_repositories.dart";
import "package:snibbo_app/features/explore/domain/use_cases/get_explore_posts.dart";
import "package:snibbo_app/features/feed/data/data_sources/remote/post_actions_remote_data.dart";
import "package:snibbo_app/features/feed/data/data_sources/remote/post_comments_remote_data.dart";
import "package:snibbo_app/features/feed/data/data_sources/remote/stories_remote_data.dart";
import "package:snibbo_app/features/feed/data/data_sources/remote/get_feed_remote_data.dart";
import "package:snibbo_app/features/feed/data/repositories/feed_repository_impl.dart";
import "package:snibbo_app/features/feed/data/repositories/post_comments_repository_impl.dart";
import "package:snibbo_app/features/feed/data/repositories/post_interactions_repository_impl.dart";
import "package:snibbo_app/features/feed/data/repositories/stories_repository_impl.dart";
import "package:snibbo_app/features/feed/domain/repositories/feed_repository.dart";
import "package:snibbo_app/features/feed/domain/repositories/post_comments_repository.dart";
import "package:snibbo_app/features/feed/domain/repositories/post_interactions_repository.dart";
import "package:snibbo_app/features/feed/domain/repositories/stories_repository.dart";
import "package:snibbo_app/features/feed/domain/usecases/get_feed_usecase.dart";
import "package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart";
import "package:snibbo_app/features/profile/data/data_sources/remote/profile_remote_data.dart";
import "package:snibbo_app/features/profile/data/repositories/profile_repository_impl.dart";
import "package:snibbo_app/features/profile/domain/repositories/profile_repository.dart";
import "package:snibbo_app/features/profile/domain/usecases/update_profile_usecase.dart";
import "package:snibbo_app/features/user/data/data_sources/remote/user_remote_data.dart";
import "package:snibbo_app/features/user/data/repositories/user_repository_impl.dart";
import "package:snibbo_app/features/user/domain/repositories/user_repository.dart";
import "package:snibbo_app/features/user/domain/usecases/follow_usecase.dart";
import "package:snibbo_app/features/user/domain/usecases/get_user_posts_usecase.dart";
import "package:snibbo_app/features/user/domain/usecases/get_user_saved_posts.dart";
import "package:snibbo_app/features/user/domain/usecases/unfollow_usecase.dart";
import "package:snibbo_app/features/user/domain/usecases/user_profile_usecase.dart";

final sl = GetIt.instance;

void setupServiceLocator() {

  sl.registerSingleton<ApiService>(ApiService());

  sl.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());

  sl.registerSingleton<AuthRemoteData>(AuthRemoteData());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<LoginUsecase>(
    LoginUsecase(authRepository: sl<AuthRepository>()),
  );

  sl.registerSingleton<RegisterUsecase>(
    RegisterUsecase(authRepository: sl<AuthRepository>()),
  );

  sl.registerSingleton<ForgetPasswordUsecase>(
    ForgetPasswordUsecase(authRepository: sl<AuthRepository>()),
  );

  sl.registerSingleton<GetFeedRemoteData>(GetFeedRemoteData());

  sl.registerSingleton<PostActionsRemoteData>(PostActionsRemoteData());

  sl.registerSingleton<StoriesRemoteData>(StoriesRemoteData());

  sl.registerSingleton<FeedRepository>(FeedRepositoryImpl());

  sl.registerSingleton<GetFeedPostsUsecase>(
    GetFeedPostsUsecase(feedRepository: sl<FeedRepository>()),
  );

  sl.registerSingleton<ImagePicker>(ImagePicker());

  sl.registerSingleton<PostCommentsRemoteData>(PostCommentsRemoteData());

  sl.registerSingleton<ContentCreatorRemoteData>(ContentCreatorRemoteData());

  sl.registerSingleton<ContentCreatorRepository>(
    ContentCreatorRepositoryImpl(),
  );

  sl.registerSingleton<CreateStoryUsecase>(
    CreateStoryUsecase(
      contentCreatorRepository: sl<ContentCreatorRepository>(),
    ),
  );

  sl.registerSingleton<CreatePostUsecase>(
    CreatePostUsecase(contentCreatorRepository: sl<ContentCreatorRepository>()),
  );

  sl.registerSingleton<UploadImageUsecase>(
    UploadImageUsecase(
      contentCreatorRepository: sl<ContentCreatorRepository>(),
    ),
  );

  sl.registerSingleton<UserRemoteData>(UserRemoteData());
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());
  sl.registerSingleton<FollowUsecase>(FollowUsecase());

  sl.registerSingleton<UnfollowUsecase>(UnfollowUsecase());

  sl.registerSingleton<UserProfileUsecase>(UserProfileUsecase());

      sl.registerSingleton<ProfileRemoteData>(ProfileRemoteData());
      sl.registerSingleton<ProfileRepository>(ProfileRepositoryImpl());
      sl.registerSingleton<UpdateProfileUsecase>(UpdateProfileUsecase());
      sl.registerSingleton<GetUserPostsUsecase>(GetUserPostsUsecase());
      sl.registerSingleton<GetUserSavedPostsUsecase>(GetUserSavedPostsUsecase());

      sl.registerSingleton<ExploreRepositories>(ExploreRepositoriesImpl());
      sl.registerSingleton<ExploreRemoteData>(ExploreRemoteData());
      sl.registerSingleton<GetExplorePostsUsecase>(GetExplorePostsUsecase());

      sl.registerSingleton<PostInteractionsRepository>(PostInteractionsRepositoryImpl());
      sl.registerSingleton<StoriesRepository>(StoriesRepositoryImpl());
      sl.registerSingleton<PostCommentsRepository>(PostCommentsRepositoryImpl());
      sl.registerSingleton<PostsUsecase>(PostsUsecase());
}
