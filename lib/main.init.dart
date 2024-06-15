part of 'main.dart';

Future<ProviderContainer> init() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  LocaleSettings.useDeviceLocale();
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

  if (!Hive.isBoxOpen(C.hive.app)) {
    await Hive.openBox(C.hive.app, encryptionCipher: Utils.hiveCipher);
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
  if (kReleaseMode) exit(1);
}
