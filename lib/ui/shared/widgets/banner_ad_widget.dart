import 'package:catt_catt/ui/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/services/admob_service.dart';

class BannerAdWidget extends HookConsumerWidget {
  final AdSize adSize;
  const BannerAdWidget(this.adSize, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adFuture = useState<Future<BannerAd?>>(Future.value(null));

    useEffect(() {
      adFuture.value = ref.read(admobService.notifier).loadBannerAd(adSize);
      return null; // No cleanup necessary
    }, []);

    return FutureBuilder<BannerAd?>(
      future: adFuture.value,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Text("Error loading ad");
        }
        final bannerAd = snapshot.data;
        if (bannerAd == null) {
          return const Text("Ad is null");
        }
        return Container(
          alignment: Alignment.center,
          width: adSize.width.toDouble(),
          height: adSize.height.toDouble(),
          child: AdWidget(ad: bannerAd),
        );
      },
    );
  }
}
