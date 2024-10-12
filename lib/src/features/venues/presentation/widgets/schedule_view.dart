import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/venue_detail_page_controller.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GetBuilder<VenueDetailPageController>(
      builder: (_) {
        return const Center(
          child: Text("Schedule View"),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
