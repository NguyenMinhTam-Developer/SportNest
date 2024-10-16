import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_nest_flutter/src/core/routes/pages.dart';
import '../../../units/presentation/controllers/unit_list_page_controller.dart';
import '../../../units/presentation/pages/unit_list_page.dart';

class SlotsView extends StatefulWidget {
  const SlotsView({super.key, required this.venueId});

  final String venueId;

  @override
  State<SlotsView> createState() => _SlotsViewState();
}

class _SlotsViewState extends State<SlotsView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: GetBuilder<UnitListPageController>(
        init: UnitListPageController(),
        builder: (_) {
          return UnitListWidget(future: _.fetchUnitListFuture);
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "unit_fab",
        onPressed: () => Get.toNamed(Routes.unitCreate.replaceFirst(':venueId', widget.venueId)),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
