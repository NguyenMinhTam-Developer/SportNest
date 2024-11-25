import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../shared/extensions/x_number.dart';

import '../../../../library/spacing.dart';
import '../../../../shared/widgets/metric_item.dart';

class Metrics extends StatelessWidget {
  const Metrics({
    super.key,
    required this.totalRevenue,
    required this.totalBookings,
  });

  final String totalRevenue;
  final int totalBookings;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: UntitledUiSpacing.xl,
      crossAxisSpacing: UntitledUiSpacing.xl,
      padding: EdgeInsets.symmetric(horizontal: UntitledUiSpacing.xl),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        MetricItem(
          title: LocaleKeys.total_revenue.tr,
          value: totalRevenue,
          icon: const Icon(Symbols.paid_rounded),
        ),
        MetricItem(
          title: LocaleKeys.total_bookings.tr,
          value: totalBookings.toThousandSeparator(),
          icon: const Icon(Symbols.event_available_rounded),
        ),
      ],
    );
  }
}
