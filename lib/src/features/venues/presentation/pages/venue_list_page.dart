import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../controllers/application_controller.dart';
import '../../../../core/design/color.dart';
import '../../../../core/design/shadow.dart';
import '../../../../core/design/typography.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../../../../shared/widgets/list_indicators.dart';
import '../controllers/venue_list_page_controller.dart';

class VenueListPage extends GetView<VenueListPageController> {
  const VenueListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VenueListPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.my_venues.tr),
            actions: [
              IconButton(
                icon: const Icon(Symbols.add_business_rounded),
                tooltip: '${LocaleKeys.add.tr} ${LocaleKeys.venue.tr}',
                onPressed: controller.onAddVenuePressed,
              ),
            ],
          ),
          body: SafeArea(child: Obx(() {
            var venues = ApplicationController.instance.venueList.value;

            if (venues.isEmpty) {
              return ListIndicator(
                icon: Symbols.store_rounded,
                label: LocaleKeys.you_dont_have_any_venue.tr,
              );
            }

            return RefreshIndicator(
              onRefresh: () async => ApplicationController.instance.fetchVenueList(),
              child: ListView.separated(
                itemCount: venues.length,
                padding: EdgeInsets.all(16.w),
                clipBehavior: Clip.none,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 16.h);
                },
                itemBuilder: (BuildContext context, int index) {
                  var venue = venues[index];

                  return InkWell(
                    onTap: () => controller.onVenuePressed(venue.id),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          AppShadow.softShadow,
                        ],
                      ),
                      child: EKAutoLayout(
                        direction: EKAutoLayoutDirection.horizontal,
                        gap: 16.w,
                        children: [
                          Container(
                            width: 84.w,
                            height: 84.w,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor.surface,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Icon(
                              Symbols.store_rounded,
                              size: 48.w,
                              color: AppColor.primaryColor.main,
                            ),
                          ),
                          Expanded(
                            child: EKAutoLayout(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              gap: 8.h,
                              children: [
                                Text(
                                  venue.name,
                                  style: AppTypography.bodyMedium.bold.copyWith(color: AppColor.neutralColor.shade100),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  venue.address,
                                  style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade60),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                EKAutoLayout(
                                  direction: EKAutoLayoutDirection.horizontal,
                                  gap: 8.w,
                                  children: [
                                    Expanded(
                                      child: EKAutoLayout(
                                        direction: EKAutoLayoutDirection.horizontal,
                                        gap: 8.w,
                                        children: [
                                          Icon(
                                            Symbols.sunny_rounded,
                                            size: AppTypography.bodySmall.medium.fontSize,
                                            color: AppColor.primaryColor.main,
                                          ),
                                          Expanded(
                                            child: Text(
                                              DateFormat("h:mm aa").format(venue.openTime),
                                              style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade100),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: EKAutoLayout(
                                        direction: EKAutoLayoutDirection.horizontal,
                                        gap: 8.w,
                                        children: [
                                          Icon(
                                            Symbols.bedtime_rounded,
                                            size: AppTypography.bodySmall.medium.fontSize,
                                            color: AppColor.primaryColor.main,
                                          ),
                                          Expanded(
                                            child: Text(
                                              DateFormat("h:mm aa").format(venue.closeTime),
                                              style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade100),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          })),
        );
      },
    );
  }
}
