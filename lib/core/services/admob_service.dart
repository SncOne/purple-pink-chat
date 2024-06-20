import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/constants.dart';
import '../../utils/print.dart';

final admobService = StateNotifierProvider<AdmobService, BannerAd?>(
  (ref) => AdmobService(),
);

class AdmobService extends StateNotifier<BannerAd?> {
  AdmobService() : super(null);

  Future<BannerAd?> loadBannerAd(AdSize adSize) async {
    final bannerAd = BannerAd(
      adUnitId: C.ads.banner,
      size: adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          Print.log('$ad loaded.');
          state = ad as BannerAd;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          Print.log('BannerAd failed to load: $error');
          ad.dispose();
          state = null;
        },
      ),
    );

    await bannerAd.load();
    return bannerAd;
  }

  Future<void> videoAd() async {
    await RewardedAd.load(
      adUnitId: C.ads.rewarded,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          Print.log('$ad loaded.');
          ad.show(onUserEarnedReward: (ad, rewardItem) {});
        },
        onAdFailedToLoad: (LoadAdError error) {
          Print.log('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  Future<void> loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: C.ads.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          Print.log('InterstitialAd loaded.');
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
          );
          ad.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          Print.log('Failed to load an interstitial ad: ${error.message}');
        },
      ),
    );
  }
}
