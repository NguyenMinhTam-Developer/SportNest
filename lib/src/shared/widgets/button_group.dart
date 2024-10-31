import 'package:flutter/material.dart';

import '../../library/colors.dart';
import '../../library/spacing.dart';
import '../../library/typography.dart';

class ButtonGroup extends StatelessWidget {
  const ButtonGroup({
    super.key,
    required this.items,
    this.onTap,
    required this.currentIndex,
  });

  final List<GroupButtonItem> items;
  final int currentIndex;
  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UntitledUiSpacing.md),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
            color: UntitledUiColors.primary.lightGrey.shade950.withOpacity(0.05),
          ),
        ],
      ),
      foregroundDecoration: BoxDecoration(
        border: Border.all(color: UntitledUiColors.primary.lightGrey.shade200, width: 1, strokeAlign: BorderSide.strokeAlignInside),
        borderRadius: BorderRadius.circular(UntitledUiSpacing.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: items
            .map(
              (e) => _buildItem(
                child: e.child,
                isActive: currentIndex == items.indexOf(e),
                onTap: () => onTap?.call(items.indexOf(e)),
                isLast: items.indexOf(e) == items.length - 1,
                isFirst: items.indexOf(e) == 0,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildItem({required Widget child, required bool isActive, required VoidCallback onTap, required bool isLast, required bool isFirst}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.only(
        topLeft: isFirst ? Radius.circular(UntitledUiSpacing.md) : Radius.zero,
        bottomLeft: isFirst ? Radius.circular(UntitledUiSpacing.md) : Radius.zero,
        topRight: isLast ? Radius.circular(UntitledUiSpacing.md) : Radius.zero,
        bottomRight: isLast ? Radius.circular(UntitledUiSpacing.md) : Radius.zero,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        constraints: const BoxConstraints(minHeight: 40),
        padding: EdgeInsets.symmetric(horizontal: UntitledUiSpacing.xl, vertical: UntitledUiSpacing.md),
        decoration: BoxDecoration(
          color: isActive ? UntitledUiColors.primary.base.white : UntitledUiColors.primary.base.white.withOpacity(0.0),
          border: Border(
            right: BorderSide(color: UntitledUiColors.primary.lightGrey.shade200, width: 1, strokeAlign: BorderSide.strokeAlignInside),
          ),
        ),
        child: IconTheme(
          data: IconThemeData(
            size: 20,
            color: UntitledUiColors.primary.lightGrey.shade700,
          ),
          child: DefaultTextStyle(
            style: UntitledUiTypography.textSm.semiBold.copyWith(
              color: UntitledUiColors.primary.lightGrey.shade700,
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

class GroupButtonItem {
  final Widget child;

  const GroupButtonItem({required this.child});
}
