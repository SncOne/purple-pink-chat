import 'package:flutter/material.dart';

import '../../../utils/extensions.dart';
import 'touchable_opacity.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
    this.text, {
    super.key,
    this.textStyle,
    this.onPress,
    this.bgColor,
    this.radius,
    this.stretch = true,
    this.padding,
  });
  final String text;
  final TextStyle? textStyle;
  final void Function()? onPress;
  final Color? bgColor;
  final BorderRadius? radius;
  final bool stretch;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onPress ?? () {},
      child: Container(
        width: stretch ? context.width : null,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.orange,
          borderRadius: radius ?? const BorderRadius.all(Radius.circular(8)),
        ),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 64, vertical: 14),
        child: Text(
          text,
          style:
              textStyle ?? const TextStyle(fontSize: 17, color: Colors.black),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
