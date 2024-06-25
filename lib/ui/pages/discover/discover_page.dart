import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/core/services/notification_service.dart';
import 'package:catt_catt/ui/shared/widgets/banner_ad_widget.dart';
import 'package:catt_catt/ui/shared/widgets/empty_widget.dart';
import 'package:catt_catt/ui/shared/widgets/profile_cards.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:catt_catt/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class DiscoverPage extends HookConsumerWidget {
  const DiscoverPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(notificationServiceProvider).requestNotificationPermission();

    return Scaffold(
      appBar: AppBar(
        title: Text(t.discover),
        actions: [
          ElevatedButton(
              onPressed: () async {
                Utils.show.dialog(
                  context,
                  Empty.dialog(content: Text(t.filter)),
                );
                ref.read(authService).getProfilesStream();
              },
              child: SvgPicture.asset(R.icons.filter))
        ],
      ),
      body: const ProfileCards(),
      bottomNavigationBar: const BannerAdWidget(AdSize.banner),
    );
  }
}
