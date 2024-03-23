import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:catt_catt/ui/shared/widgets/touchable_opacity.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/styles.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CustomImage.asset(R.images.welcomePhoto1),
                    S.sizedBox.h24,
                    CustomImage.asset(R.images.welcomePhoto2),
                  ],
                ),
                S.sizedBox.w24,
                Column(
                  children: [
                    CustomImage.asset(R.images.welcomePhoto3),
                    S.sizedBox.h24,
                    CustomImage.asset(R.images.welcomePhoto4),
                  ],
                )
              ],
            ),
            S.sizedBox.h32,
            Text(
              t.appIntro,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.deepPurple),
            ),
            S.sizedBox.h32,
            TouchableOpacity(
              child: Container(
                padding: S.edgeInsets.all20,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: S.borderRadius.radius50,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.getStarted,
                      style: const TextStyle(color: Colors.white),
                    ),
                    S.sizedBox.w12,
                    CustomImage.asset(
                      R.icons.send,
                      svgColor: Colors.white,
                    ),
                  ],
                ),
              ),
              onTap: () {
                context.router.replace(const LoginRoute());
              },
            )
          ],
        ),
      ),
    );
  }
}
