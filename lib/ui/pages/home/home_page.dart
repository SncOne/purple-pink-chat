import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/services/notification_service.dart';
import 'package:catt_catt/ui/shared/widgets/custom_bottom_navigation_bar.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    //ref.watch(userProvider.future);
    ref.watch(notificationServiceProvider).requestNotificationPermission();
    
    return AutoTabsScaffold(
      lazyLoad: true,
      routes: const [
        DiscoverRoute(),
        MessagesRoute(),
        LikesRoute(),
        ProfileRoute(),
      ],
      transitionBuilder: (_, child, __) => child,
      bottomNavigationBuilder: (final _, final __) {
        return const CustomBottomNavigationBar();
      },
    );
  }
}
