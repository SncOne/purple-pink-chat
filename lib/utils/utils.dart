import 'dart:async';
import 'dart:convert';

import 'package:catt_catt/utils/styles.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'constants.dart';
import 'extensions.dart';
import 'print.dart';

part 'utils.formatters.dart';
part 'utils.show.dart';

const _service = 'Utils';

abstract class Utils {
  const Utils._();
  static final show = _Show();

  /// TextFormField(
  ///   inputFormatters: [Utils.formatters.phone],
  /// );
  static const formatters = _Formatters();

  /// TextFormField(
  ///   validator: Utils.validators.email,
  /// );

  /// parameter of [tapAgainToExitToast]
  static DateTime? _currentBackPressTime;

  /// Show tap again to exit toast message when go back
  ///
  /// return WillPopScope(
  ///   onWillPop: Utils.tapAgainToExitToast,
  ///   child: Scaffold(),
  /// );
  static Future<bool> tapAgainToExitToast(
    BuildContext context,
    String text,
  ) async {
    Print.log('tapAgainToExitToast', _service);
    final now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > const Duration(seconds: 3)) {
      _currentBackPressTime = now;
      await show.toast(context, text);
      return false;
    }
    return true;
  }

  /// parameter of [throttle]
  static DateTime? _lastRun;

  static void throttle(Duration duration, void Function() callback) {
    final lastRun = _lastRun;
    final now = DateTime.now();
    if (lastRun == null) {
      _lastRun = now;
      callback();
    } else {
      final diff = now.difference(lastRun);
      if (diff < duration) {
        return;
      }
      _lastRun = now;
      callback();
    }
  }

  static HiveAesCipher get hiveCipher {
    return HiveAesCipher(utf8.encode(C.secureKey));
  }

  static Future<String> loadJson(String path) async {
    return await rootBundle.loadString(path);
  }

  static bool isTrueParser(Object? value) => int.tryParse('$value') == 1;

  static Future<String?> getTextFromClipboard() async {
    return (await Clipboard.getData('text/plain'))?.text;
  }

  static void onReady(Future<void> Function() method) {
    // ignore: prefer-async-await, this is an exception
    SchedulerBinding.instance.endOfFrame.then((_) async => await method());
  }

  static Future<Map<String, List<String>>> getAssetPaths() async {
    final manifestContent = await loadJson('AssetManifest.json');
    final Map<String, Object?> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys
        .where((key) => key.contains('images/'))
        .where((key) => !key.contains('.gitkeep'))
        .toList();
    final iconPaths = manifestMap.keys
        .where((key) => key.contains('icons/*.svg'))
        .where((key) => !key.contains('.gitkeep'))
        .toList();
    return {'icons': iconPaths, 'images': imagePaths};
  }

  bool get isDialogOpen => Utils.show.isDialogOpen;
  bool get isToastOpen => Utils.show.isToastOpen;
  bool get isBottomSheetOpen => Utils.show.isBottomSheetOpen;
}
