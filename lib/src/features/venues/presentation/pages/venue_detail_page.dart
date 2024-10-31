import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../core/design/color.dart';
import '../../../../core/design/typography.dart';
import '../../../../core/routes/pages.dart';
import '../controllers/venue_detail_page_controller.dart';
import '../widgets/details_view.dart';
import '../widgets/slots_view.dart';

class VenueDetailPage extends GetView<VenueDetailPageController> {
  const VenueDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VenueDetailPageController>(
      builder: (controller) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(controller.venue?.name ?? ""),
              actions: controller.venue != null
                  ? [
                      PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: "edit",
                              child: Text(LocaleKeys.edit.tr),
                            ),
                            PopupMenuItem(
                              value: "delete",
                              child: Text(LocaleKeys.delete.tr),
                            ),
                          ];
                        },
                        onSelected: (value) async {
                          switch (value) {
                            case "edit":
                              Get.toNamed(Routes.venueEdit.replaceFirst(":venueId", controller.venue!.id));
                              break;
                            case "delete":
                              Get.dialog(AlertDialog(
                                title: Text(
                                  LocaleKeys.deleteVenueTitle.tr,
                                  style: AppTypography.heading5.semiBold,
                                ),
                                content: Text(
                                  LocaleKeys.deleteVenueDescription.tr,
                                  style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColor.neutralColor.shade100,
                                    ),
                                    child: Text(LocaleKeys.cancel.tr),
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      Get.back();
                                      controller.deleteVenue();
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: AppColor.errorColor.main,
                                    ),
                                    child: Text(LocaleKeys.delete.tr),
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
            body: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                DetailsView(),
                SlotsView(),
              ],
            ),
          ),
        );
      },
    );
  }
}
