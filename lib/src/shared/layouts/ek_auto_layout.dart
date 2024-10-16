import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

enum EKAutoLayoutDirection {
  vertical,
  horizontal,
  wrap,
}

class EKAutoLayout extends StatelessWidget {
  EKAutoLayout({
    super.key,
    this.direction = EKAutoLayoutDirection.vertical,
    this.padding,
    this.gap = 0,
    this.crossAxisCount = 1,
    this.alignment = Alignment.topCenter,
    this.width,
    this.height,
    this.border,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisSize? mainAxisSize,
    this.showDebugBorder = false,
    this.children = const [],
  }) {
    switch (direction) {
      case EKAutoLayoutDirection.vertical:
        this.mainAxisAlignment = mainAxisAlignment ?? MainAxisAlignment.start;
        this.crossAxisAlignment = crossAxisAlignment ?? CrossAxisAlignment.center;
        this.mainAxisSize = mainAxisSize ?? MainAxisSize.min;
        break;
      case EKAutoLayoutDirection.horizontal:
        this.mainAxisAlignment = mainAxisAlignment ?? MainAxisAlignment.start;
        this.crossAxisAlignment = crossAxisAlignment ?? CrossAxisAlignment.center;
        this.mainAxisSize = mainAxisSize ?? MainAxisSize.min;
        break;
      case EKAutoLayoutDirection.wrap:
        this.mainAxisAlignment = mainAxisAlignment ?? MainAxisAlignment.start;
        this.crossAxisAlignment = crossAxisAlignment ?? CrossAxisAlignment.start;
        this.mainAxisSize = mainAxisSize ?? MainAxisSize.min;
        break;
    }
  }

  final EKAutoLayoutDirection direction;
  final EdgeInsetsGeometry? padding;
  final double gap;
  final AlignmentGeometry alignment;
  final double? width;
  final double? height;
  final int crossAxisCount;
  final BoxBorder? border;
  late final MainAxisAlignment mainAxisAlignment;
  late final CrossAxisAlignment crossAxisAlignment;
  late final MainAxisSize mainAxisSize;
  final bool showDebugBorder;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    Widget layout;

    if (direction == EKAutoLayoutDirection.wrap) {
      layout = MasonryGridView.count(
        padding: padding,
        itemCount: children.length,
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: gap,
        mainAxisSpacing: gap,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return children[index];
        },
      );
    } else {
      List<Widget> spacedChildren = [];

      for (int i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);

        if (gap > 0) {
          if (i != children.length - 1) {
            spacedChildren.add(SizedBox(height: gap, width: gap));
          }
        }
      }

      layout = Flex(
        clipBehavior: Clip.none,
        textBaseline: TextBaseline.alphabetic,
        direction: direction == EKAutoLayoutDirection.vertical ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: spacedChildren,
      );
    }

    return Container(
      padding: direction == EKAutoLayoutDirection.wrap ? null : padding,
      width: width,
      height: height,
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        border: border,
      ),
      child: direction == EKAutoLayoutDirection.wrap ? layout : Align(alignment: alignment, child: layout),
    );
  }
}
