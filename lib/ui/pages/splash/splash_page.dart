import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

import '../../shared/widgets/loading_overlay.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      onReady: () async {
        await Future.delayed(const Duration(seconds: 7));
        // ignore: use_build_context_synchronously
        await context.router.replace(const HomeRoute());
      },
      child: Scaffold(
        body: UpgradeAlert(
          upgrader: Upgrader(),
          child: const Center(
            child: Text('temple'),
          ),
        ),
      ),
    );
  }
}
