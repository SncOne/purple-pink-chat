import 'package:auto_route/auto_route.dart';
import 'package:catt_catt/ui/shared/widgets/custom_button.dart';
import 'package:catt_catt/ui/shared/widgets/custom_image.dart';
import 'package:flutter/material.dart';

enum ButtonOrder { vertical, verticalReversed, horizontal, horizontalReversed }

class Empty extends StatelessWidget {
  const Empty.dialog({
    super.key,
    this.image,
    this.title,
    this.desc,
    this.content,
    this.buttonOrder = ButtonOrder.verticalReversed,
    this.okText,
    this.okPress,
    this.okBgColor,
    this.okTextStyle,
    this.noText,
    this.noPress,
  }) : isDialog = true;

  const Empty.page({
    super.key,
    this.image,
    this.title,
    this.desc,
    this.content,
    this.buttonOrder = ButtonOrder.verticalReversed,
    this.okText,
    this.okPress,
    this.okBgColor,
    this.okTextStyle,
    this.noText,
    this.noPress,
  }) : isDialog = false;

  final String? image;
  final String? title;
  final String? desc;
  final Widget? content;
  final ButtonOrder buttonOrder;
  final String? okText;
  final void Function()? okPress;
  final Color? okBgColor;
  final TextStyle? okTextStyle;
  final String? noText;
  final void Function()? noPress;

  final bool isDialog;

  Widget _getButtonsWithOrder(BuildContext context) {
    var buttonList = <CustomButton>[];
    final okButton = CustomButton(
      okText ?? '',
      bgColor: okBgColor,
      onPress: okPress ?? context.back,
      textStyle: okTextStyle,
    );
    final noButton = CustomButton(
      noText ?? '',
      bgColor: Colors.transparent,
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      onPress: noPress ?? context.back,
    );

    if (okText != null) buttonList.add(okButton);
    if (noText != null) buttonList.add(noButton);

    final isButtonOrderReversed = buttonOrder == ButtonOrder.verticalReversed ||
        buttonOrder == ButtonOrder.horizontalReversed;

    if (isButtonOrderReversed) {
      buttonList = buttonList.reversed.toList();
    }

    final isButtonOrderVertical = buttonOrder == ButtonOrder.vertical ||
        buttonOrder == ButtonOrder.verticalReversed;

    return isButtonOrderVertical
        ? Column(mainAxisSize: MainAxisSize.min, children: buttonList)
        : Row(children: buttonList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: isDialog ? null : Alignment.center,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Material(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (image != null) CustomImage.asset(image, height: 250),
                  if (image != null) const SizedBox(height: 32),
                  if (title != null)
                    Flexible(
                      child: Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  const SizedBox(height: 12),
                  if (desc != null)
                    Flexible(
                      child: Text(
                        desc!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  const SizedBox(height: 32),
                  if (content != null) content!,
                  if (content != null) const SizedBox(height: 24),
                  // ignore: avoid-returning-widgets, ignore him xd
                  _getButtonsWithOrder(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
