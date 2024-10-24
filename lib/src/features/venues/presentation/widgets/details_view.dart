import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/design/color.dart';
import '../../../../core/design/typography.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../shared/extensions/hardcode.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../../../../shared/widgets/list_indicators.dart';
import '../controllers/venue_detail_page_controller.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({super.key});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GetBuilder<VenueDetailPageController>(
      builder: (controller) {
        return FutureBuilder<VenueModel>(
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

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    venue.name,
                    style: AppTypography.heading6.bold.copyWith(color: AppColor.neutralColor.shade100),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    venue.address,
                    style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade60),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16.h),
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
                              size: AppTypography.bodySmall.medium.fontSize! + 4,
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
                              size: AppTypography.bodySmall.medium.fontSize! + 4,
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
                  SizedBox(height: 16.h),
                  Text(
                    "Description".isHardcoded,
                    style: AppTypography.bodyMedium.semiBold.copyWith(color: AppColor.neutralColor.shade100),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    venue.description,
                    style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade60),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
