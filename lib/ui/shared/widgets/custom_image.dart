import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum _ImageType { network, asset }

class CustomImage extends StatelessWidget {
  const CustomImage.network(
    this.image, {
    super.key,
    this.fit = BoxFit.contain,
    this.borderRadius,
    this.svgColor,
    this.placeHolder,
    this.errorWidget,
    this.height,
    this.width,
    this.border,
    this.boxShadow,
    this.memCacheHeight,
    this.memCacheWidth,
    this.alignment = Alignment.center,
  }) : _type = _ImageType.network;

  const CustomImage.asset(
    this.image, {
    super.key,
    this.fit = BoxFit.contain,
    this.borderRadius,
    this.svgColor,
    this.placeHolder,
    this.errorWidget,
    this.height,
    this.width,
    this.border,
    this.boxShadow,
    this.memCacheHeight,
    this.memCacheWidth,
    this.alignment = Alignment.center,
  }) : _type = _ImageType.asset;
  final String? image;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final Color? svgColor;
  final Widget? placeHolder;
  final Widget? errorWidget;
  final double? height;
  final double? width;
  final int? memCacheHeight;
  final int? memCacheWidth;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final Alignment alignment;

  final _ImageType _type;

  @override
  Widget build(BuildContext context) {
    bool isSVG() => image!.contains('.svg');
    bool isNetwork() => _type == _ImageType.network ? true : false;

    Widget tempImage;

    if (isNetwork()) {
      if (isSVG()) {
        tempImage = SvgPicture.network(
          image!,
          width: width,
          height: height,
          alignment: alignment,
          fit: fit!,
        );
      } else {
        tempImage = CachedNetworkImage(
          imageUrl: image!,
          width: width,
          alignment: alignment,
          height: height,
          fit: fit,
          memCacheHeight: memCacheHeight,
          memCacheWidth: memCacheWidth,
          placeholder: (_, __) => Center(
            child: placeHolder ?? const CircularProgressIndicator(),
          ),
          errorWidget: (_, __, ___) => errorWidget ?? const SizedBox(),
        );
      }
    } else {
      if (isSVG()) {
        tempImage = SvgPicture.asset(
          image!,
          alignment: alignment,
          width: width,
          height: height,
          colorFilter:
              ColorFilter.mode(svgColor ?? Colors.pink, BlendMode.srcIn),
          fit: fit!,
        );
      } else {
        tempImage = Image.asset(
          image!,
          width: width,
          alignment: alignment,
          height: height,
          fit: fit,
        );
      }
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        border: border,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: tempImage,
      ),
    );
  }
}
