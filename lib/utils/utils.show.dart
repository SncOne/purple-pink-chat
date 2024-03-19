// ignore_for_file: long-parameter-list, prefer-async-await, this is fine

part of 'utils.dart';

class _Show {
  bool _isDialogOpen = false;
  bool _isToastOpen = false;
  bool _isBottomSheetOpen = false;

  bool get isDialogOpen => _isDialogOpen;
  bool get isToastOpen => _isToastOpen;
  bool get isBottomSheetOpen => _isBottomSheetOpen;

  Future<T?> bottomSheet<T>(
    BuildContext context,
    Widget child, {
    bool? isDismissible,
    BorderRadius? borderRadius,
  }) {
    Print.log('bottomSheet', _service);

    _isBottomSheetOpen = true;

    return showCupertinoModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible ?? true,
      builder: (c) => AnimatedPadding(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.only(bottom: MediaQuery.of(c).viewInsets.bottom),
        child: Material(
          borderRadius:
              borderRadius ?? const BorderRadius.all(Radius.circular(16)),
          child: child,
        ),
      ),
    ).then((res) {
      _isBottomSheetOpen = false;
      return res;
    });
  }

  Future<T?> dialog<T>(
    BuildContext context,
    Widget child, {
    bool? isDismissible,
    BorderRadius? borderRadius,
  }) {
    Print.log('dialog', _service);

    _isDialogOpen = true;

    return showDialog<T>(
      context: context,
      builder: (_) => PopScope(
        canPop: isDismissible ?? true,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.only(bottom: context.bottom),
          child: Center(
            child: SizedBox(
              width: 340.w,
              child: Material(
                borderRadius:
                    borderRadius ?? const BorderRadius.all(Radius.circular(16)),
                child: child,
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: isDismissible ?? true,
    ).then((res) {
      _isDialogOpen = false;
      return res;
    });
  }

  Future<T?> toast<T>(
    BuildContext context,
    String text, {
    Duration? duration,
    FlashPosition? position,
    BorderRadius? borderRadius,
    Color? bgColor,
    TextStyle? textStyle,
    bool? isDismissible,
  }) {
    Print.log('toast', _service);

    _isToastOpen = true;

    return context
        .showFlash<T>(
      duration: duration ?? const Duration(seconds: 3),
      barrierDismissible: isDismissible ?? false,
      builder: (_, c) {
        return Flash<T>(
          controller: c,
          position: position ?? FlashPosition.bottom,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              text,
              style: textStyle ??
                  const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
            ),
          ),
        );
      },
    )
        .then((res) {
      _isToastOpen = false;
      return res;
    });
  }
}
