import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/services/notification_service.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(notificationServiceProvider).requestNotificationPermission();
    Future.delayed(const Duration(seconds: 2), () {
      context.replaceRoute(const HomeRoute());
    });
    return Scaffold(
      body: Center(
        child: CustomImage.asset(
          R.images.logo,
          borderRadius: S.borderRadius.radius16,
        ),
      ),
    );
  }
}
