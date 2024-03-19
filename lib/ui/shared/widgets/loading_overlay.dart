import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/loading_provider.dart';
import '../../../utils/enums.dart';
import '../../../utils/extensions.dart';
import 'loading_widget.dart';
import 'unfocus_area.dart';

class LoadingOverlay extends HookConsumerWidget {
  const LoadingOverlay({
    required this.child,
    this.onInit,
    this.onReady,
    this.onDispose,
    super.key,
  });

  final Widget child;

  /// replacement of [initState()]
  final void Function()? onInit;

  /// Run 1 frame after [onInit()]
  /// It is for navigation events, async request or when update state on init.
  final Future<void> Function()? onReady;

  /// replacement of [dispose()]
  final void Function()? onDispose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mounted = context.mounted;
    useEffect(
      () {
        onInit?.call();
        // ignore: prefer-async-await, this is an exception
        SchedulerBinding.instance.endOfFrame.then(
          (_) async {
            if (onReady.isNotNull && mounted) await onReady!();
          },
        );
        return onDispose?.call;
      },
      [],
    );
    final isBusy = ref.watch(loadingProvider) == LoadingState.loading;
    return PopScope(
      canPop: !isBusy,
      child: UnfocusArea(
        child: Consumer(
          builder: (_, ref, __) {
            if (!isBusy) return child;
            return IgnorePointer(
              ignoring: isBusy,
              child: Stack(
                children: [
                  Center(child: child),
                  const Opacity(
                    opacity: 0.5,
                    child: ModalBarrier(
                      dismissible: false,
                      color: Colors.black,
                    ),
                  ),
                  const LoadingWidget(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
