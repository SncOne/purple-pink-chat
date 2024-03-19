import 'package:flutter/material.dart' show AppLifecycleState;
import 'package:riverpod/riverpod.dart';

final appLifecycleStateProvider = StateProvider<AppLifecycleState?>((_) {
  return null;
});
