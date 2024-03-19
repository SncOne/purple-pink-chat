part of 'constants.dart';

class _Ads {
  const _Ads();
  String get appOpen {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/3419835294';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/5662855259';
    } else {
      throw Exception('Unsupported platform');
    }
  }

  String get banner {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw Exception('Unsupported platform');
    }
  }

  String get interstitial {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else {
      throw Exception('Unsupported platform');
    }
  }

  String get interstitialVideo {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/8691691433';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/5135589807';
    } else {
      throw Exception('Unsupported platform');
    }
  }

  String get rewarded {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else {
      throw Exception('Unsupported platform');
    }
  }

  String get rewardedInterstitial {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5354046379';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6978759866';
    } else {
      throw Exception('Unsupported platform');
    }
  }

  String get nativeAdvanced {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/2247696110';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    } else {
      throw Exception('Unsupported platform');
    }
  }

  String get nativeAdvancedVideo {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1044960115';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2521693316';
    } else {
      throw Exception('Unsupported platform');
    }
  }
}
