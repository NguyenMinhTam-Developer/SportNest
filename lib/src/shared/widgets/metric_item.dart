import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../library/colors.dart';
import '../../library/spacing.dart';
import '../../library/typography.dart';

class MetricItem extends StatelessWidget {
  const MetricItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      padding: EdgeInsets.symmetric(
        horizontal: UntitledUiSpacing.xl,
        vertical: UntitledUiSpacing.xl2,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: UntitledUiColors.primary.lightGrey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            color: UntitledUiColors.primary.lightGrey.shade950.withOpacity(0.05),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: UntitledUiColors.primary.base.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: UntitledUiColors.primary.lightGrey.shade200,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                      spreadRadius: 0,
                      color: UntitledUiColors.primary.lightGrey.shade950.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Center(child: icon),
              ),
            ],
          ),
          SizedBox(height: UntitledUiSpacing.xl),
          Text(
            title,
            style: UntitledUiTypography.textSm.semiBold.copyWith(
              color: UntitledUiColors.primary.lightGrey.shade600,
            ),
          ),
          SizedBox(height: UntitledUiSpacing.xs),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: UntitledUiTypography.displaySm.semiBold.copyWith(
                color: UntitledUiColors.primary.lightGrey.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
