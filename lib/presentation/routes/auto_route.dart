import 'package:auto_route/auto_route.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashScreenRoute.page),
    AutoRoute(page: LoginScreenRoute.page),
    AutoRoute(page: RegisterScreenRoute.page),
    AutoRoute(page: ForgotPasswordScreenRoute.page),
    AutoRoute(page: SettingsScreenRoute.page),
    AutoRoute(page: OnboardScreenRoute.page),
    AutoRoute(page: GeneralPageRoute.page, path: "/", initial: true),
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}
