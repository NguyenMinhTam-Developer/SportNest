import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/design/color.dart';
import '../../core/design/typography.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    super.key,
    this.labelText,
    this.errorText,
    this.isRequired = false,
    required this.child,
  });

  final String? labelText;
  final String? errorText;
  final bool isRequired;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (labelText != null) ...[
          RichText(
            text: TextSpan(
              text: labelText!,
              style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade100),
              children: [
                if (isRequired)
                  TextSpan(
                    text: ' *',
                    style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.errorColor.main),
                  ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
        ],
        child,
        if (errorText != null) ...[
          SizedBox(height: 8.h),
          Text(errorText!, style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.errorColor.main)),
        ],
      ],
    );
  }
}
