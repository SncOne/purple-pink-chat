import 'dart:io';

import 'package:flutter/material.dart';

part 'constants.ads.dart';
part 'constants.api.dart';
part 'constants.hive.dart';

class C {
  const C._();

  static const ads = _Ads();
  static const api = _Api();
  static const hive = _Hive();

  static const title = 'Purple & Pink';
  static const restorationScopeId = 'restorationScopeId';

  static const designSize = Size(428, 926);
  static const mainGapSize = 4.0;

  static const secureKey = '23232323232323232323232323232323';
  static const secureIVKey = '2323232323232323';

  // Firebase messaging subscription key
  static const notif = 'all';
}
