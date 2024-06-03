import 'dart:async';
import 'dart:io';

import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/lang/strings.g.dart';
import 'package:country_picker/country_picker.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upgrader/upgrader.dart';

import 'core/providers/provider_logger.dart';
import 'firebase_options.dart';
import 'utils/constants.dart';
import 'utils/extensions.dart';
import 'utils/utils.dart';

part 'main.init.dart';

void main() async {
  await runZonedGuarded(
    () async {
      final container = await init();
      runApp(
        // DevicePreview(
        //   builder: (_) => UncontrolledProviderScope(
        //     container: container,
        //     child: const MyApp(),
        //   ),
        // ),
        TranslationProvider(
          child: UncontrolledProviderScope(
            container: container,
            child: MyApp(),
          ),
        ),
      );
    },
    onError,
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: C.designSize,
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
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
                child: DevicePreview.appBuilder(context, widget),
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
      },
    );
  }
}
