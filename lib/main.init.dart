part of 'main.dart';

Future<ProviderContainer> init() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  LocaleSettings.useDeviceLocale();
  MobileAds.instance.initialize();
  // debugRepaintTextRainbowEnabled = true;
  // debugRepaintRainbowEnabled = true;
  // debugPaintSizeEnabled = true;
  // debugPaintLayerBordersEnabled = true;
  // debugPaintPointersEnabled = true;

  binding
    ..deferFirstFrame()
    ..addPostFrameCallback((_) async {
      binding.allowFirstFrame();
    });

  final container = ProviderContainer(
    observers: [if (kDebugMode) ProviderLogger()],
  );

  // MobileAds.instance.initialize();

  await Hive.initFlutter();

  if (Platform.isIOS || Platform.isMacOS) {
    StoreConfig(
      store: Store.appStore,
      apiKey: C.api.appleApiKey,
    );
  } else if (Platform.isAndroid) {
    const useAmazon = bool.fromEnvironment("amazon");
    StoreConfig(
      store: useAmazon ? Store.amazon : Store.playStore,
      apiKey: useAmazon ? C.api.amazonApiKey : C.api.googleApiKey,
    );
  }

  if (!Hive.isBoxOpen(C.hive.app)) {
    await Hive.openBox(C.hive.app, encryptionCipher: Utils.hiveCipher);
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().requestNotificationPermission();

  // Enable debug logs before calling `configure`.
  await Purchases.setLogLevel(LogLevel.debug);

  /*
    - appUserID is nil, so an anonymous ID will be generated automatically by the Purchases SDK. Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids

    - observerMode is false, so Purchases will automatically handle finishing transactions. Read more about Observer Mode here: https://docs.revenuecat.com/docs/observer-mode
    */
  PurchasesConfiguration configuration;
  if (StoreConfig.isForAmazonAppstore()) {
    configuration = AmazonConfiguration(StoreConfig.instance.apiKey)
      ..appUserID = null
      ..observerMode = false;
  } else {
    configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
      ..appUserID = null
      ..observerMode = false;
  }
  await Purchases.configure(configuration);

  // container.read(dynamicLinksServiceProvider);

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };

  ErrorWidget.builder = (details) {
    return Material(
      child: Center(
        child: Text('$details', textDirection: TextDirection.ltr),
      ),
    );
  };

  return container;
}

void onError(Object error, StackTrace stack) {
  debugPrint('error: $error, stackTrace: $stack');
}
