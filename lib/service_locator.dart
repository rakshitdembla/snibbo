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
import "package:snibbo_app/features/feed/data/data_sources/remote/feed_posts_remote_data.dart";
import "package:snibbo_app/features/feed/data/data_sources/remote/feed_stories_remote_data.dart";
import "package:snibbo_app/features/feed/data/data_sources/remote/get_feed_remote_data.dart";
import "package:snibbo_app/features/feed/data/repositories/feed_repository_impl.dart";
import "package:snibbo_app/features/feed/domain/repositories/feed_repository.dart";
import "package:snibbo_app/features/feed/domain/usecases/posts_usecase.dart";
import "package:snibbo_app/features/feed/domain/usecases/stories_usecase.dart";
import "package:snibbo_app/features/feed/domain/usecases/get_feed_usecase.dart";
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
  //** --- Common ServiceLocators --- */
  sl.registerSingleton<ApiService>(ApiService());

  sl.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());

  //** --- Auth ServiceLocators --- */
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

  //** --- Feed ServiceLocators --- */
  sl.registerSingleton<GetFeedRemoteData>(GetFeedRemoteData());

  sl.registerSingleton<FeedPostsRemoteData>(FeedPostsRemoteData());

  sl.registerSingleton<FeedStoriesRemoteData>(FeedStoriesRemoteData());

  sl.registerSingleton<FeedRepository>(FeedRepositoryImpl());

  sl.registerSingleton<GetFeedPostsUsecase>(
    GetFeedPostsUsecase(feedRepository: sl<FeedRepository>()),
  );

  sl.registerSingleton<PostsUsecase>(
    PostsUsecase(feedRepository: sl<FeedRepository>()),
  );

  sl.registerSingleton<StoriesUsecase>(
    StoriesUsecase(feedRepository: sl<FeedRepository>()),
  );

  sl.registerSingleton<ImagePicker>(ImagePicker());

  //** --- Create ServiceLocators --- */
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

  //** --- User ServiceLocators --- */

  sl.registerSingleton<UserRemoteData>(UserRemoteData());
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());
  sl.registerSingleton<FollowUsecase>(FollowUsecase());

  sl.registerSingleton<UnfollowUsecase>(UnfollowUsecase());

  sl.registerSingleton<UserProfileUsecase>(UserProfileUsecase());

    //** --- Profile ServiceLocators --- */

      sl.registerSingleton<ProfileRemoteData>(ProfileRemoteData());
      sl.registerSingleton<ProfileRepository>(ProfileRepositoryImpl());
      sl.registerSingleton<UpdateProfileUsecase>(UpdateProfileUsecase());
      sl.registerSingleton<GetUserPostsUsecase>(GetUserPostsUsecase());
      sl.registerSingleton<GetUserSavedPostsUsecase>(GetUserSavedPostsUsecase());
}
