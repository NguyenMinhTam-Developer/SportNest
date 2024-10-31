import 'package:flutter/material.dart';

class UntitledUiTypography {
  static _TypographyItem display2Xl = const _TypographyItem(
    fontSize: 72,
    height: 1.25, // 90px / 72px = 1.25
    letterSpacing: -0.02,
  );

  static _TypographyItem displayXl = const _TypographyItem(
    fontSize: 60,
    height: 1.2, // 72px / 60px = 1.2
    letterSpacing: -0.02,
  );

  static _TypographyItem displayLg = const _TypographyItem(
    fontSize: 48,
    height: 1.25, // 60px / 48px = 1.25
    letterSpacing: -0.02,
  );

  static _TypographyItem displayMd = const _TypographyItem(
    fontSize: 36,
    height: 1.22, // 44px / 36px ≈ 1.22
    letterSpacing: -0.02,
  );

  static _TypographyItem displaySm = const _TypographyItem(
    fontSize: 30,
    height: 1.27, // 38px / 30px ≈ 1.27
    letterSpacing: -0.02,
  );

  static _TypographyItem displayXs = const _TypographyItem(
    fontSize: 24,
    height: 1.33, // 32px / 24px ≈ 1.33
    letterSpacing: -0.02,
  );

  static _TypographyItem textXl = const _TypographyItem(
    fontSize: 20,
    height: 1.5, // 30px / 20px = 1.5
    letterSpacing: -0.02,
  );

  static _TypographyItem textLg = const _TypographyItem(
    fontSize: 18,
    height: 1.56, // 28px / 18px ≈ 1.56
    letterSpacing: -0.02,
  );

  static _TypographyItem textMd = const _TypographyItem(
    fontSize: 16,
    height: 1.5, // 24px / 16px = 1.5
    letterSpacing: -0.02,
  );

  static _TypographyItem textSm = const _TypographyItem(
    fontSize: 14,
    height: 1.43, // 20px / 14px ≈ 1.43
    letterSpacing: -0.02,
  );

  static _TypographyItem textXs = const _TypographyItem(
    fontSize: 12,
    height: 1.5, // 18px / 12px = 1.5
    letterSpacing: -0.02,
  );
}

class _TypographyItem extends TextStyle {
  const _TypographyItem({
    required double fontSize,
    required double height,
    required double letterSpacing,
  }) : super(fontSize: fontSize, height: height, letterSpacing: letterSpacing, fontWeight: FontWeight.w500);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
}
