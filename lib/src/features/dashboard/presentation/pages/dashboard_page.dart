import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../shared/extensions/x_datetime.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../library/colors.dart';
import '../../../../library/typography.dart';
import '../../../../services/authentication_service.dart';

import '../../../../data/models/booking_model.dart';
import '../../../../library/spacing.dart';
import '../../../../shared/widgets/button_group.dart';
import '../../../schedule/presentation/pages/schedule_page.dart';
import '../controllers/dashboard_page_controller.dart';
import '../widgets/metrics.dart';

class DashboardPage extends GetWidget<DashboardPageController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GetBuilder<AuthService>(
                  builder: (_) {
                    return Text(
                      greetingMessage(_.currentUserModel?.firstName ?? ""),
                      style: UntitledUiTypography.textXl.semiBold.copyWith(
                        color: UntitledUiColors.primary.lightGrey.shade900,
                      ),
                    );
                  },
                ),
                Text(
                  DateTime.now().formatDate(),
                  style: UntitledUiTypography.textMd.regular.copyWith(
                    color: UntitledUiColors.primary.lightGrey.shade600,
                  ),
                ),
              ],
            ),
          ),
          body: RefreshIndicator(
            onRefresh: controller.refreshDashboard,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: UntitledUiSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: UntitledUiSpacing.xl),
                    child: Text(
                      LocaleKeys.dashboard.tr,
                      style: UntitledUiTypography.textXl.semiBold.copyWith(
                        color: UntitledUiColors.primary.lightGrey.shade900,
                      ),
                    ),
                  ),
                  SizedBox(height: UntitledUiSpacing.xl2),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: UntitledUiSpacing.xl),
                    child: Row(
                      children: [
                        ButtonGroup(
                          currentIndex: controller.selectedTimeFrameIndex,
                          onTap: controller.onTimeFrameSelected,
                          items: [
                            GroupButtonItem(
                              child: Text(LocaleKeys.year.tr),
                            ),
                            GroupButtonItem(
                              child: Text(LocaleKeys.month.tr),
                            ),
                            GroupButtonItem(
                              child: Text(LocaleKeys.week.tr),
                            ),
                            GroupButtonItem(
                              child: Text(LocaleKeys.today.tr),
                            ),
                          ],
                        ),
                        SizedBox(width: UntitledUiSpacing.xl),
                        Container(),
                      ],
                    ),
                  ),
                  SizedBox(height: UntitledUiSpacing.xl2),
                  Metrics(
                    totalRevenue: controller.totalRevenue,
                    totalBookings: controller.totalBookings,
                  ),
                  SizedBox(height: UntitledUiSpacing.xl4),
                  UpcomingBookings(
                    bookings: controller.upcomingBookings,
                  ).paddingSymmetric(horizontal: UntitledUiSpacing.xl),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String greetingMessage(String name) {
    final hour = DateTime.now().hour;
    String greeting;

    if (hour < 12) {
      greeting = LocaleKeys.goodMorning.tr;
    } else if (hour < 17) {
      greeting = LocaleKeys.goodAfternoon.tr;
    } else {
      greeting = LocaleKeys.goodEvening.tr;
    }

    return "$greeting, $name!";
  }
}

class UpcomingBookings extends GetView<DashboardPageController> {
  const UpcomingBookings({
    super.key,
    required this.bookings,
  });

  final List<BookingModel> bookings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          LocaleKeys.upcomingBookings.tr,
          style: UntitledUiTypography.textLg.semiBold.copyWith(
            color: UntitledUiColors.primary.lightGrey.shade900,
          ),
        ),
        SizedBox(height: UntitledUiSpacing.md),
        if (bookings.isEmpty)
          Text(
            LocaleKeys.youDontHaveAnyUpcomingBookings.tr,
            style: UntitledUiTypography.textMd.regular.copyWith(
              color: UntitledUiColors.primary.lightGrey.shade600,
            ),
          ),
        ListView.separated(
          itemCount: bookings.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: UntitledUiSpacing.xl);
          },
          itemBuilder: (BuildContext context, int index) {
            var booking = bookings[index];

            return BookingItem(
              booking: booking,
              showVenueName: true,
              showDate: true,
              onBookingItemPressed: controller.onBookingItemPressed,
            );
          },
        ),
      ],
    );
  }
}
