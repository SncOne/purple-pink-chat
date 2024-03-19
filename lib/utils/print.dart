import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class Print {
  const Print._();
  static void log(Object? message, [String? service]) {
    if (kDebugMode) developer.log('$message', name: service ?? '');
  }

  static void info(Object? info, [String? service]) {
    if (kDebugMode) {
      var serviceName = '';
      service == null ? serviceName = '[INFO]' : serviceName = '[$service]';
      print('\u001b[32m 🍀 $serviceName $info');
    }
  }

  static void warning(Object? warning, [String? service]) {
    if (kDebugMode) {
      var serviceName = '';
      service == null ? serviceName = '[WARNING]' : serviceName = '[$service]';
      print('\u001B[34m 🔥 $serviceName $warning');
    }
  }

  static void error(Object? error, [String? service]) {
    if (kDebugMode) {
      var serviceName = '';
      service == null ? serviceName = '[ERROR]' : serviceName = '[$service]';
      print('\u001b[31m 💀 $serviceName $error');
    }
  }

  static void json(Object? message) {
    if (kDebugMode) developer.log(jsonEncode(message));
  }
}
