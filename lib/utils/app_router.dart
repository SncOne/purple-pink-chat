import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/models/user.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/ui/pages/auth/createProfile/create_profile_page.dart';
import 'package:catt_catt/ui/pages/auth/forgot/forgot_password_page.dart';
import 'package:catt_catt/ui/pages/auth/login/login_page.dart';
import 'package:catt_catt/ui/pages/auth/register/register_page.dart';
import 'package:catt_catt/ui/pages/discover/discover_page.dart';
import 'package:catt_catt/ui/pages/home/home_page.dart';
import 'package:catt_catt/ui/pages/likes/likes_page.dart';
import 'package:catt_catt/ui/pages/messages/messages_page.dart';
import 'package:catt_catt/ui/pages/chat/chat_page.dart';
import 'package:catt_catt/ui/pages/onboarding/onboarding_page.dart';
import 'package:catt_catt/ui/pages/profile/editProfilePage/edit_profile_page.dart';
import 'package:catt_catt/ui/pages/profile/profileDetails/profile_details_page.dart';
import 'package:catt_catt/ui/pages/profile/profile_page.dart';
import 'package:catt_catt/ui/pages/splash/splash_page.dart';
import 'package:catt_catt/ui/pages/welcome/welcome_page.dart';
import 'package:catt_catt/ui/shared/pages/no_connection/no_connection_page.dart';
import 'package:catt_catt/ui/shared/pages/not_found/not_found_page.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: WelcomeRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: CreateProfileRoute.page),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(
          page: HomeRoute.page,
          guards: [
            AuthGuard(),
            CreateProfileGuard(),
            OnboardingGuard(),
          ],
          children: [
            AutoRoute(page: DiscoverRoute.page),
            AutoRoute(page: LikesRoute.page),
            AutoRoute(page: ProfileRoute.page),
            AutoRoute(page: MessagesRoute.page),
          ],
        ),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: ChatRoute.page),
        AutoRoute(page: ProfileDetailsRoute.page),
        AutoRoute(page: NotFoundRoute.page),
        AutoRoute(page: NoConnectionRoute.page),
      ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    const auth = AuthService();
    if (auth.user == null) {
      resolver.redirect(const WelcomeRoute(), replace: true);
      return;
    }
    resolver.next(true);
  }
}

class CreateProfileGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final context = router.navigatorKey.currentContext;
    const auth = AuthService();
    if (auth.user == null) {
      resolver.redirect(const WelcomeRoute(), replace: true);
      return;
    }
    if ((auth.user?.displayName ?? '').isEmpty) {
      resolver.redirect(const CreateProfileRoute(), replace: true);
      return;
    }
    if (context!.mounted) {
      Utils.show.toast(context, t.hello(name: auth.user!.displayName!));
    }
    resolver.next();
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
