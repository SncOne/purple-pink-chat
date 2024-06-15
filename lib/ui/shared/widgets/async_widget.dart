import 'package:catt_catt/utils/print.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AsyncWidget<T> extends StatelessWidget {
  const AsyncWidget({
    required this.data,
    required this.builder,
    this.loading,
    this.error,
    super.key,
  });

  final AsyncValue<T> data;
  final Widget Function(T) builder;
  final Widget? loading;
  final Widget Function(Object, StackTrace?)? error;
  @override
  Widget build(BuildContext context) {
    return data.when(
      data: builder,
      error: error ??
          (e, err) {
            Print.error(e, 'e');
            Print.warning(err, 'err');
            return const Center(child: Text('err'));
          },
      loading: () {
        return loading ?? const Center(child: CircularProgressIndicator());
      },
    );
  }
}
