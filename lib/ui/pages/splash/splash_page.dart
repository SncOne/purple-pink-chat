import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:upgrader/upgrader.dart';

@RoutePage()
class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      context.replaceRoute(const HomeRoute());
    });
    return Scaffold(
      body: UpgradeAlert(
        upgrader: Upgrader(),
        child: Center(
          child: CustomImage.asset(R.images.logo),
        ),
      ),
    );
  }
}
