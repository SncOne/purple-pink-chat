import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/enums.dart';

final loadingProvider = StateNotifierProvider<LoadingNotifier, LoadingState>(
  (_) => LoadingNotifier(),
  name: 'loadingProvider',
);

class LoadingNotifier extends StateNotifier<LoadingState> {
  LoadingNotifier() : super(LoadingState.idle);

  bool isBusy() => state == LoadingState.loading;

  void set(LoadingState value) => state = value;

  void setLoaded() => state = LoadingState.loaded;
  void setLoading() => state = LoadingState.loading;
  void setError() => state = LoadingState.error;
  void setIdle() => state = LoadingState.idle;

  @override
  String toString() => 'LoadingNotifier';
}
