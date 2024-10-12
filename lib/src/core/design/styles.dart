import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color.dart';
import 'typography.dart';

var kInputDecoration = InputDecorationTheme(
  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
  fillColor: AppColor.neutralColor.shade10,
  filled: true,
  hintStyle: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(
      color: AppColor.neutralColor.shade40,
      width: 1,
      style: BorderStyle.solid,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(
      color: AppColor.primaryColor.main,
      width: 2,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(
      color: AppColor.errorColor.main,
      width: 1,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(
      color: AppColor.errorColor.main,
      width: 2,
    ),
  ),
  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide.none),
);
