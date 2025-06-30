import 'package:auto_route/auto_route.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashScreenRoute.page, path: "/", initial: true),
    AutoRoute(page: LoginScreenRoute.page),
    AutoRoute(page: RegisterScreenRoute.page),
    AutoRoute(page: ForgotPasswordScreenRoute.page),
    AutoRoute(page: SettingsScreenRoute.page),
    AutoRoute(page: OnboardScreenRoute.page),
    AutoRoute(page: ProfileViewRoute.page),
    AutoRoute(page: LinkPostViewScreenRoute.page),
    AutoRoute(page: SearchUserScreenRoute.page),
    AutoRoute(page: StoryViewScreenRoute.page),
    AutoRoute(page: FetchStoriesLoadingRoute.page),
    AutoRoute(page: EditProfileScreenRoute.page),
    AutoRoute(page: GeneralPageRoute.page),
    AutoRoute(page: UserProfileScreenRoute.page),
    AutoRoute(page: UserConnectionsScreenRoute.page),
    AutoRoute(page: ProfileScreenRoute.page),
    AutoRoute(page: PostLikedUsersScreenRoute.page),
    AutoRoute(page: CommentLikedUsersScreenRoute.page),
    AutoRoute(page: ReplyLikedUsersScreenRoute.page),
    AutoRoute(page: ExplorePostsViewScreenRoute.page),
    AutoRoute(page: UserPostsViewScreenRoute.page),
    AutoRoute(page: SavedPostsViewScreenRoute.page),
    AutoRoute(page: UpdatePostScreenRoute.page),
    AutoRoute(page: ChatListScreenRoute.page),
    AutoRoute(page: ChatScreenRoute.page),
  ];
  @override
  List<AutoRouteGuard> get guards => [];
}
