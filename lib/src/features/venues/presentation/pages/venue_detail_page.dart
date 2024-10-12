import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import '../../../../shared/widgets/list_indicators.dart';
import '../widgets/booking_view.dart';
import '../widgets/details_view.dart';
import '../widgets/schedule_view.dart';
import '../widgets/slots_view.dart';
import '../../../../core/design/color.dart';
import '../../../../core/design/typography.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../shared/extensions/hardcode.dart';

import '../../../../core/routes/pages.dart';
import '../controllers/venue_detail_page_controller.dart';

class VenueDetailPage extends GetView<VenueDetailPageController> {
  const VenueDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VenueDetailPageController>(
      builder: (controller) {
        return FutureBuilder<VenueModel>(
          future: controller.fetchVenueFuture,
          builder: (context, snapshot) => DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                title: Text(snapshot.data?.name ?? ""),
                actions: snapshot.hasData
                    ? [
                        PopupMenuButton(
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: "edit",
                                child: Text("Edit".isHardcoded),
                              ),
                              PopupMenuItem(
                                value: "delete",
                                child: Text("Delete".isHardcoded),
                              ),
                            ];
                          },
                          onSelected: (value) {
                            switch (value) {
                              case "edit":
                                Get.toNamed(Routes.venueEdit, arguments: snapshot.requireData);
                                break;
                              case "delete":
                                Get.dialog(AlertDialog(
                                  title: Text(
                                    "Delete Venue".isHardcoded,
                                    style: AppTypography.heading5.semiBold,
                                  ),
                                  content: Text(
                                    "Are you sure you want to delete this venue?".isHardcoded,
                                    style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      style: TextButton.styleFrom(
                                        foregroundColor: AppColor.neutralColor.shade100,
                                      ),
                                      child: Text("Cancel".isHardcoded),
                                    ),
                                    FilledButton(
                                      onPressed: () {
                                        Get.back();
                                        controller.deleteVenue(snapshot.requireData.id);
                                      },
                                      style: FilledButton.styleFrom(
                                        backgroundColor: AppColor.errorColor.main,
                                      ),
                                      child: Text("Delete".isHardcoded),
                                    ),
                                  ],
                                ));
                                break;
                            }
                          },
                        ),
                      ]
                    : null,
                bottom: const TabBar(
                  tabs: [
                    Tab(text: "Details"),
                    Tab(text: "Booking"),
                    Tab(text: "Schedule"),
                    Tab(text: "Units"),
                  ],
                ),
              ),
              body: FutureBuilder<VenueModel>(
                future: controller.fetchVenueFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return ListIndicator(
                      icon: Symbols.error_rounded,
                      label: "Failed to load venue detail".isHardcoded,
                    );
                  }

                  var venue = snapshot.requireData;

                  return TabBarView(
                    children: [
                      const DetailsView(),
                      BookingsView(venueId: venue.id),
                      const ScheduleView(),
                      SlotsView(venueId: venue.id),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
