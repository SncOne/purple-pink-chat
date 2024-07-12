import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/main.dart';
import 'package:catt_catt/utils/app_router.dart';
import 'package:catt_catt/utils/print.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final connectivityProvider =
    StateNotifierProvider<ConnectivityService, ConnectivityResult>((ref) {
  return ConnectivityService()..init();
});

class ConnectivityService extends StateNotifier<ConnectivityResult> {
  ConnectivityService() : super(ConnectivityResult.none);

  final _connectivity = Connectivity();

  void init() {
    _connectivity.onConnectivityChanged.listen((results) {
      if (results.isNotEmpty) {
        state = results.first;
        if (state == ConnectivityResult.none) {
          whenConnectionLost();
        } else {
          whenConnectionComeBack();
        }
      }
    });
  }

  void whenConnectionLost() {
    Print.error('Connection lost');
    final router = AutoRouter.of(appRouter.navigatorKey.currentContext!);
    router.push(const NoConnectionRoute());
  }

  void whenConnectionComeBack() {
    Print.error('Connection came back');
    final router = AutoRouter.of(appRouter.navigatorKey.currentContext!);
    router.maybePop();
  }
}
