import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:sport_nest_flutter/generated/locales.g.dart';

import '../../../../shared/widgets/list_indicators.dart';
import '../../../units/presentation/pages/unit_list_page.dart';
import '../controllers/venue_detail_page_controller.dart';

class SlotsView extends StatefulWidget {
  const SlotsView({super.key});

  @override
  State<SlotsView> createState() => _SlotsViewState();
}

class _SlotsViewState extends State<SlotsView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: GetBuilder<VenueDetailPageController>(
        builder: (controller) {
          var units = controller.venue?.unitList ?? [];

          if (units.isEmpty) {
            return ListIndicator(
              icon: Symbols.category_rounded,
              label: LocaleKeys.noUnitsFound.tr,
            );
          }

          return ListView.separated(
            itemCount: units.length,
            padding: const EdgeInsets.all(16),
            clipBehavior: Clip.none,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 16);
            },
            itemBuilder: (BuildContext context, int index) {
              var unit = units[index];

              return UnitItemWidget(
                unit: unit,
                onDetailPressed: () => controller.onUnitItemPressed(unit),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "unit_fab",
        onPressed: VenueDetailPageController.instance.onUnitAddPressed,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
