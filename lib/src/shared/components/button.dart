import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/design/color.dart';
import '../../core/design/typography.dart';
import '../layouts/ek_auto_layout.dart';

enum ButtonType { primary, secondary, outline }

class ButtonComponent extends StatelessWidget {
  ButtonComponent.primary({
    super.key,
    required this.onPressed,
    required String this.label,
    this.prefixIcon,
    this.suffixIcon,
  }) {
    backgroundColor = AppColor.primaryColor.main;
    foregroundColor = AppColor.neutralColor.shade10;
    borderColor = null;
  }

  ButtonComponent.secondary({
    super.key,
    required this.onPressed,
    required String this.label,
    this.prefixIcon,
    this.suffixIcon,
  }) {
    backgroundColor = AppColor.primaryColor.surface;
    foregroundColor = AppColor.primaryColor.main;
    borderColor = null;
  }

  ButtonComponent.outline({
    super.key,
    required this.onPressed,
    required String this.label,
    this.prefixIcon,
    this.suffixIcon,
  }) {
    backgroundColor = Colors.transparent;
    foregroundColor = AppColor.neutralColor.shade100;
    borderColor = AppColor.neutralColor.shade40;
  }

  final void Function()? onPressed;
  late final String? label;
  late final Widget? icon;
  late final Widget? prefixIcon;
  late final Widget? suffixIcon;

  late final Color? backgroundColor;
  late final Color? foregroundColor;
  late final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(Size.zero),
        maximumSize: WidgetStatePropertyAll(Size.fromHeight(52.h)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        side: borderColor != null
            ? WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return null;
                }

                return BorderSide(color: borderColor!, width: 1.w);
              })
            : null,
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h)),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColor.neutralColor.shade30;
          }

          return backgroundColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColor.neutralColor.shade60;
          }

          return foregroundColor;
        }),
        textStyle: WidgetStatePropertyAll(AppTypography.bodyMedium.semiBold),
      ),
      child: EKAutoLayout(
        direction: EKAutoLayoutDirection.horizontal,
        gap: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) SizedBox(width: 20.w, height: 20.h, child: FittedBox(child: prefixIcon)),
          Text(label ?? ""),
          if (suffixIcon != null) SizedBox(width: 20.w, height: 20.h, child: FittedBox(child: suffixIcon)),
        ],
      ),
    );
  }
}

class IconButtonComponent extends StatelessWidget {
  const IconButtonComponent({
    super.key,
    required this.onPressed,
    required this.label,
    this.type = ButtonType.primary,
  });

  final void Function()? onPressed;
  final Widget label;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(
          color: type == ButtonType.outline ? AppColor.neutralColor.shade40 : Colors.transparent,
          width: 1.w,
        ),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 40.w,
          width: 40.w,
          padding: EdgeInsets.all(8.w),
          child: label,
        ),
      ),
    );
  }
}
