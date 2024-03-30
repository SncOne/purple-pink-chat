import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upgrader/upgrader.dart';

import '../../shared/widgets/loading_overlay.dart';

@RoutePage()
class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LoadingOverlay(
      onReady: () async {
        await Future.delayed(const Duration(seconds: 3));
        // ignore: use_build_context_synchronously
        await context.router.replace(const HomeRoute());
      },
      child: Scaffold(
        body: UpgradeAlert(
          upgrader: Upgrader(),
          child: Center(
            child: CustomImage.asset(R.images.logo),
          ),
        ),
      ),
    );
  }
}
