// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_nest_flutter/src/core/design/color.dart';

class AppTypography {
  static _Style heading1 = _Style(fontSize: 64, lineHeight: 72);
  static _Style heading2 = _Style(fontSize: 48, lineHeight: 56);
  static _Style heading3 = _Style(fontSize: 40, lineHeight: 48);
  static _Style heading4 = _Style(fontSize: 32, lineHeight: 40);
  static _Style heading5 = _Style(fontSize: 24, lineHeight: 32);
  static _Style heading6 = _Style(fontSize: 18, lineHeight: 26);

  static _Style bodyLarge = _Style(fontSize: 16, lineHeight: 24);
  static _Style bodyMedium = _Style(fontSize: 14, lineHeight: 20);
  static _Style bodySmall = _Style(fontSize: 12, lineHeight: 16);
}

class _Style {
  final double fontSize;
  final double lineHeight;

  _Style({
    required this.fontSize,
    required this.lineHeight,
  });

  TextStyle get bold => TextStyle(
        fontSize: fontSize.sp,
        height: lineHeight / fontSize,
        fontWeight: FontWeight.w700,
        color: AppColor.neutralColor.shade100,
      );

  TextStyle get semiBold => TextStyle(
        fontSize: fontSize.sp,
        height: lineHeight / fontSize,
        fontWeight: FontWeight.w600,
        color: AppColor.neutralColor.shade100,
      );

  TextStyle get medium => TextStyle(
        fontSize: fontSize.sp,
        height: lineHeight / fontSize,
        fontWeight: FontWeight.w500,
        color: AppColor.neutralColor.shade100,
      );

  TextStyle get regular => TextStyle(
        fontSize: fontSize.sp,
        height: lineHeight / fontSize,
        fontWeight: FontWeight.w400,
        color: AppColor.neutralColor.shade100,
      );
}
