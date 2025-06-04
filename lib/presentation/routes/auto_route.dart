import 'package:auto_route/auto_route.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashScreenRoute.page),
    AutoRoute(page: LoginScreenRoute.page),
    AutoRoute(page: RegisterScreenRoute.page),
    AutoRoute(page: ForgotPasswordScreenRoute.page),
    AutoRoute(page: SettingsScreenRoute.page),
    AutoRoute(page: FeedScreenRoute.page),
    AutoRoute(page: OnboardScreenRoute.page),
    AutoRoute(page: ProfileViewRoute.page),
    AutoRoute(page: PostsViewScreenRoute.page),
    AutoRoute(page: SearchScreenRoute.page),
    AutoRoute(page: StoryViewScreenRoute.page),
    AutoRoute(page: FetchStoriesLoadingRoute.page),
    AutoRoute(page: EditProfileScreenRoute.page),
    CustomRoute(
      page: FetchStoriesLoadingSlidePageRoute.page,
      transitionsBuilder: TransitionsBuilders.slideRight,
      duration: Duration(milliseconds: 300),
    ),
    CustomRoute(
      page: StoryViewSlidePageRoute.page,
      transitionsBuilder: TransitionsBuilders.slideRight,
      duration: Duration(milliseconds: 300),
    ),
    AutoRoute(page: GeneralPageRoute.page, path: "/", initial: true),
  ];
  @override
  List<AutoRouteGuard> get guards => [];
}
