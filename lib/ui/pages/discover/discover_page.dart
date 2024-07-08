import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/core/providers/providers.dart';
import 'package:catt_catt/ui/pages/discover/filter_bottom_sheet.dart';
import 'package:catt_catt/ui/shared/widgets/banner_ad_widget.dart';
import 'package:catt_catt/ui/shared/widgets/profile_cards.dart';
import 'package:catt_catt/utils/assets.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:catt_catt/core/services/auth_service.dart';
import 'package:catt_catt/core/services/location_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class DiscoverPage extends HookConsumerWidget {
  const DiscoverPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(locationService).determinePosition();
    ref.read(authService).getTokenAndPosition();
    return Scaffold(
      appBar: AppBar(
        title: Text(t.discover),
        actions: [
          ElevatedButton(
              onPressed: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const FilterBottomSheet();
                  },
                ).then((_) {
                  ref.invalidate(profilesProvider);
                });
              },
              child: SvgPicture.asset(R.icons.filter))
        ],
      ),
      body: const ProfileCards(),
      bottomNavigationBar: const BannerAdWidget(AdSize.banner),
    );
  }
}
