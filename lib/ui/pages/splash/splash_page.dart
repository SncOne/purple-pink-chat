import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
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
