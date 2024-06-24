import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/print.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    Print.log(
      '${'${provider.name}'.split('.').first} | $value',
      'didAddProvider',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    Print.log(
      '${provider.name}'.split('.').first,
      'didDisposeProvider',
    );
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    Print.log(
      '${'${provider.name}'.split('.').first} | $previousValue -> $newValue',
      'didUpdateProvider',
    );
  }

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    Print.log(
      '${'${provider.name}'.split('.').first} | $error',
      'providerDidFail',
    );
  }
}
