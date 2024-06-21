import 'dart:async';

//import 'package:catt_catt/core/services/notification_service.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
// import 'package:catt_catt/utils/store_config.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:purchases_flutter/purchases_flutter.dart';

import 'core/providers/provider_logger.dart';
import 'firebase_options.dart';
import 'utils/constants.dart';
import 'utils/extensions.dart';
import 'utils/utils.dart';

part 'main.init.dart';

void main() async {
  final container = await init();
  runApp(
    TranslationProvider(
      child: UncontrolledProviderScope(
        container: container,
        child: const MyApp(),
      ),
    ),
  );
}

final _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: C.title,
        restorationScopeId: C.restorationScopeId,
        builder: (context, widget) {
          return MediaQuery(
            data: context.mediaQuery
                .copyWith(textScaler: const TextScaler.linear(1)),
            child: widget!,
          );
        },
        routerConfig: _appRouter.config(),
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: const [
          ...GlobalMaterialLocalizations.delegates,
          GlobalWidgetsLocalizations.delegate,
          CountryLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
      ),
    );
  }
}
