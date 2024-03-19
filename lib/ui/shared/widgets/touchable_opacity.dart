import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../utils/extensions.dart';

class TouchableOpacity extends HookWidget {
  const TouchableOpacity({required this.child, this.onTap, super.key});
  final Widget child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDown = useState(false);

    return RepaintBoundary(
      child: GestureDetector(
        onTap: () {
          context.unfocus();
          onTap?.call();
        },
        onTapDown: (_) => isDown.value = true,
        onTapUp: (_) => isDown.value = false,
        onTapCancel: () => isDown.value = false,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 50),
          opacity: isDown.value ? 0.5 : 1,
          child: child,
        ),
      ),
    );
  }
}
