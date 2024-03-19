import 'package:flutter/material.dart';

import '../../../utils/extensions.dart';

class UnfocusArea extends StatelessWidget {
  const UnfocusArea({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.unfocus,
      child: child,
    );
  }
}
