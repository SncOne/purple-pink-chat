import 'package:flutter/material.dart';

class S {
  static final borderRadius = _BorderRadius();
  static final colors = _Colors();
  static final edgeInsets = _EdgeInsets();
  static final fontWeights = _FontWeights();
  static final sizedBox = _SizedBox();
  static final textStyles = _TextStyles();
}

class _BorderRadius {
  final zero = BorderRadius.circular(0);
  final radius5 = BorderRadius.circular(5);
  final radius8 = BorderRadius.circular(8);
  final radius10 = BorderRadius.circular(10);
  final radius12 = BorderRadius.circular(12);
  final radius16 = BorderRadius.circular(16);
  final radius50 = BorderRadius.circular(50);
}

class _Colors {
  final transparent = Colors.transparent;
  final bgColor = const Color(0xffFBFBFB);
  final black = Colors.black;
  final black87 = Colors.black87;
  final dividerGrey = const Color(0xffECECEC);
  final white = Colors.white;
  final grey = const Color(0xff989898);
  final orange = const Color(0xffFFBE00);
  final green = const Color(0xff81E842);
  final alertOrange = const Color(0xffFF9900);
  final yellow = const Color(0xffF6C73B);
  final red = const Color(0xffFF0000);
}

class _EdgeInsets {
  final zero = EdgeInsets.zero;
  final all5 = const EdgeInsets.all(5);
  final all10 = const EdgeInsets.all(10);
  final all12 = const EdgeInsets.all(12);
  final all20 = const EdgeInsets.all(20);
  final all24 = const EdgeInsets.all(24);
  final all32 = const EdgeInsets.all(32);

  final h20v12 = const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
  final h64v14 = const EdgeInsets.symmetric(vertical: 14, horizontal: 64);

  final h12 = const EdgeInsets.symmetric(horizontal: 16);

  final v12 = const EdgeInsets.symmetric(vertical: 12);
}

class _FontWeights {
  final w300 = FontWeight.w300;
  final w700 = FontWeight.w700;
}

class _SizedBox {
  final h6 = const SizedBox(height: 6);
  final h12 = const SizedBox(height: 12);
  final h24 = const SizedBox(height: 24);
  final h32 = const SizedBox(height: 32);
  final h46 = const SizedBox(height: 46);
  final w12 = const SizedBox(width: 12);
  final w24 = const SizedBox(width: 24);
  final w32 = const SizedBox(width: 32);
}

class _TextStyles {
  final font12 = TextStyle(
    fontSize: 12,
    color: S.colors.black,
  );
  final font12Bold = TextStyle(
    fontSize: 12,
    fontWeight: S.fontWeights.w700,
    color: S.colors.black,
  );
  final font14 = TextStyle(
    fontSize: 14,
    color: S.colors.black,
  );
  final font14White = TextStyle(
    fontSize: 14,
    color: S.colors.white,
  );
  final font14Bold = TextStyle(
    fontSize: 14,
    fontWeight: S.fontWeights.w700,
    color: S.colors.black,
  );
  final font16White = TextStyle(
    fontSize: 16,
    color: S.colors.white,
  );
  final font16 = TextStyle(
    fontSize: 16,
    color: S.colors.black,
  );
  final font16Bold = TextStyle(
    fontSize: 16,
    fontWeight: S.fontWeights.w700,
    color: S.colors.black,
  );
  final font16Grey = TextStyle(
    fontSize: 16,
    color: S.colors.grey,
  );
  final font18BoldWhite = TextStyle(
    fontSize: 16,
    fontWeight: S.fontWeights.w700,
    color: S.colors.white,
  );
  final font20Bold = TextStyle(
    fontSize: 20,
    fontWeight: S.fontWeights.w700,
    color: S.colors.black,
  );
  final font20BoldWhite = TextStyle(
    fontSize: 20,
    fontWeight: S.fontWeights.w700,
    color: S.colors.white,
  );
  final font24Bold = TextStyle(
    fontSize: 24,
    fontWeight: S.fontWeights.w700,
    color: S.colors.black,
  );
  final font24BoldWhite = TextStyle(
    fontSize: 24,
    fontWeight: S.fontWeights.w700,
    color: S.colors.white,
  );
  final font28w300 = TextStyle(
    fontSize: 28,
    fontWeight: S.fontWeights.w300,
    color: S.colors.black,
  );
  final font28Bold = TextStyle(
    fontSize: 28,
    fontWeight: S.fontWeights.w700,
    color: S.colors.black,
  );
}
