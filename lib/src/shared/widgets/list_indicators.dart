import 'package:flutter/material.dart';

import '../../core/design/color.dart';
import '../../core/design/typography.dart';

class ListIndicator extends StatelessWidget {
  const ListIndicator({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade100),
          ),
        ],
      ),
    );
  }
}
