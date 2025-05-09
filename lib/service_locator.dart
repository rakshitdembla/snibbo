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
import "package:snibbo_app/features/feed/data/data_sources/remote/feed_posts_remote_data.dart";
import "package:snibbo_app/features/feed/data/data_sources/remote/feed_stories_remote_data.dart";
import "package:snibbo_app/features/feed/data/data_sources/remote/get_feed_remote_data.dart";
import "package:snibbo_app/features/feed/data/repositories/feed_repository_impl.dart";
import "package:snibbo_app/features/feed/domain/repositories/feed_repository.dart";
import "package:snibbo_app/features/feed/domain/usecases/feed_posts_usecase.dart";
import "package:snibbo_app/features/feed/domain/usecases/feed_stories_usecase.dart";
import "package:snibbo_app/features/feed/domain/usecases/get_feed_usecase.dart";

final sl = GetIt.instance;

void setupServiceLocator() {
  //**common service locators
  sl.registerSingleton<ApiService>(ApiService());
  sl.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());

  //**auth service locators
  sl.registerSingleton<AuthRemoteData>(AuthRemoteData());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  //--auth usecase service locators
  sl.registerSingleton<LoginUsecase>(
    LoginUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerSingleton<RegisterUsecase>(
    RegisterUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerSingleton<ForgetPasswordUsecase>(
    ForgetPasswordUsecase(authRepository: sl<AuthRepository>()),
  );

  //**feed service locators

  sl.registerSingleton<GetFeedRemoteData>(GetFeedRemoteData());
  sl.registerSingleton<FeedPostsRemoteData>(FeedPostsRemoteData());
  sl.registerSingleton<FeedStoriesRemoteData>(FeedStoriesRemoteData());
  sl.registerSingleton<FeedRepository>(FeedRepositoryImpl());
  sl.registerSingleton<GetFeedPostsUsecase>(
    GetFeedPostsUsecase(feedRepository: sl<FeedRepository>()),
  );
  sl.registerSingleton<FeedPostsUsecase>(
    FeedPostsUsecase(feedRepository: sl<FeedRepository>()),
  );
  sl.registerSingleton<FeedStoriesUsecase>(
    FeedStoriesUsecase(feedRepository: sl<FeedRepository>()),
  );
  sl.registerSingleton<ImagePicker>(
    ImagePicker(),
  );
}
