import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../core/design/color.dart';
import '../../../../core/design/typography.dart';
import '../../../../core/routes/pages.dart';
import '../../../../data/enums/booking_status_enum.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../shared/extensions/hardcode.dart';
import '../../../../shared/widgets/list_indicators.dart';
import '../controllers/venue_detail_page_controller.dart';
import '../widgets/details_view.dart';
import '../widgets/slots_view.dart';
import 'venue_notification_page.dart';

class VenueDetailPage extends GetView<VenueDetailPageController> {
  const VenueDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VenueDetailPageController>(
      builder: (controller) {
        return FutureBuilder<VenueModel>(
          future: controller.fetchVenueFuture,
          builder: (context, snapshot) => DefaultTabController(
            length: 2,
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
                          onSelected: (value) async {
                            switch (value) {
                              case "edit":
                                var result = await Get.toNamed(Routes.venueEdit.replaceFirst(":venueId", snapshot.requireData.id), arguments: snapshot.requireData);

                                if (result == true) {
                                  controller.isUpdated = true;
                                  controller.fetchVenue(snapshot.requireData.id);
                                  controller.update();
                                }
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
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const DetailsView(),
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
