import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final connectivityProvider = StateNotifierProvider<ConnectivityService, bool>(
  (_) => ConnectivityService().._init(),
);

class ConnectivityService extends StateNotifier<bool> {
  ConnectivityService() : super(true);

  final _conn = Connectivity();

  Connectivity get conn => _conn;

  Future<void> _init() async {
    final e = await _conn.checkConnectivity();
    state = _check(e);
    if (!state) _action();
    _conn.onConnectivityChanged.listen((e) {
      state = _check(e);
      if (!state) _action();
    });
  }

  bool _check(ConnectivityResult e) {
    return e == ConnectivityResult.none ? false : true;
  }

  // Run when connection lost
  void _action() {
    if (state) {
      whenConnectionComeBack();
    } else {
      whenConnectionLost();
    }
  }

  /// Custom behaivor when the app lost the internet connection
  void whenConnectionLost() {}

  /// Custom behaivor when the app get back the internet connection
  void whenConnectionComeBack() {}
}
