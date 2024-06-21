part of 'main.dart';

Future<ProviderContainer> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseCrashlytics.instance.app = app;

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  LocaleSettings.useDeviceLocale();
  MobileAds.instance.initialize();

  final container = ProviderContainer(
    observers: [if (kDebugMode) ProviderLogger()],
  );

  await Hive.initFlutter();
  // TODO: BURAYA BAKARLAR
  // if (Platform.isIOS || Platform.isMacOS) {
  //   StoreConfig(
  //     store: Store.appStore,
  //     apiKey: C.api.appleApiKey,
  //   );
  // } else if (Platform.isAndroid) {
  //   const useAmazon = bool.fromEnvironment("amazon");
  //   StoreConfig(
  //     store: useAmazon ? Store.amazon : Store.playStore,
  //     apiKey: useAmazon ? C.api.amazonApiKey : C.api.googleApiKey,
  //   );
  // }

  if (!Hive.isBoxOpen(C.hive.app)) {
    await Hive.openBox(C.hive.app, encryptionCipher: Utils.hiveCipher);
  }

  FirebaseAnalytics.instance.logAdImpression();

  await container
      .read(notificationServiceProvider)
      .requestNotificationPermission();
//TODO: Open it

  // Enable debug logs before calling `configure`.
  // await Purchases.setLogLevel(LogLevel.debug);

  // /*
  //   - appUserID is nil, so an anonymous ID will be generated automatically by the Purchases SDK. Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids

  //   - observerMode is false, so Purchases will automatically handle finishing transactions. Read more about Observer Mode here: https://docs.revenuecat.com/docs/observer-mode
  //   */
  // PurchasesConfiguration configuration;
  // if (StoreConfig.isForAmazonAppstore()) {
  //   configuration = AmazonConfiguration(StoreConfig.instance.apiKey)
  //     ..appUserID = null
  //     ..observerMode = false;
  // } else {
  //   configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
  //     ..appUserID = null
  //     ..observerMode = false;
  // }
  // await Purchases.configure(configuration);

  return container;
}
