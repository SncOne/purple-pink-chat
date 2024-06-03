import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/ui/shared/widgets/custom_bottom_navigation_bar.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter(
      routes: const [
        DiscoverRoute(),
        ProfileRoute(),
        LikesRoute(),
        MessagesRoute(),
      ],
      transitionBuilder: (context, child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        Print.warning(child);
        return CustomBottomNavigationBar(tabsRouter, child);
      },
    );
  }
}
