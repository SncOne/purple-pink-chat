import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/ui/pages/auth/forgot/forgot_password_page.dart';
import 'package:catt_catt/ui/pages/auth/login/login_page.dart';
import 'package:catt_catt/ui/pages/auth/register/register_page.dart';
import 'package:catt_catt/ui/pages/home/home_page.dart';
import 'package:catt_catt/ui/pages/onboarding/onboarding_page.dart';
import 'package:catt_catt/ui/pages/splash/splash_page.dart';
import 'package:catt_catt/ui/pages/welcome/welcome_page.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/utils.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: WelcomeRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: HomeRoute.page, guards: [
          AuthGuard(),
          OnboardingGuard(),
        ]),
        AutoRoute(page: OnboardingRoute.page),
      ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final context = router.navigatorKey.currentContext;
    const authService = AuthService();
    authService.authState.listen((user) {
      if (user != null) {
        resolver.next(true);
        if (user.displayName != null) {
          Utils.show.toast(
            context!,
            t.hello(name: user.displayName!),
          );
        }
      } else {
        resolver.redirect(const WelcomeRoute(), replace: true);
      }
    });
  }
}

class OnboardingGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next(true);
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    // if (authenticated) {
    //   // if user is authenticated we continue
    //   resolver.next(true);
    // } else {
    //   // we redirect the user to our login page
    //   // tip: use resolver.redirect to have the redirected route
    //   // automatically removed from the stack when the resolver is completed
    //   resolver.redirect(LoginRoute(onResult: (success) {
    //     // if success == true the navigation will be resumed
    //     // else it will be aborted
    //     resolver.next(success);
    //   }));
    // }
  }
}
