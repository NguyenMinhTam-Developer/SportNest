import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/design/color.dart';
import '../../../../core/design/shadow.dart';
import '../../../../core/design/typography.dart';
import '../../../../core/routes/pages.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../services/app_service.dart';
import '../../../../shared/extensions/hardcode.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../../../../shared/widgets/list_indicators.dart';
import '../controllers/booking_list_page_controller.dart';

class BookingListPage extends GetView<BookingListPageController> {
  const BookingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingListPageController>(
      builder: (controller) {
        return FutureBuilder<List<BookingModel>>(
          future: controller.fetchBookingsFuture,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Bookings'.isHardcoded),
                actions: snapshot.hasData
                    ? [
                        IconButton(
                          icon: const Icon(Symbols.add_rounded),
                          tooltip: 'Add Booking'.isHardcoded,
                          onPressed: () => Get.toNamed(Routes.bookingCreate.replaceFirst(':id', snapshot.requireData.first.venueId!)),
                        ),
                      ]
                    : null,
              ),
              body: SafeArea(
                child: BookingListWidget(
                  future: controller.fetchBookingsFuture,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class BookingListWidget extends StatelessWidget {
  const BookingListWidget({
    super.key,
    required this.future,
  });

  final Future<List<BookingModel>>? future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookingModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return ListIndicator(
            icon: Symbols.today_rounded,
            label: "Failed to load booking".isHardcoded,
          );
        }

        if (snapshot.data!.isEmpty) {
          return ListIndicator(
            icon: Symbols.today_rounded,
            label: "You don't have any booking".isHardcoded,
          );
        }

        var bookings = snapshot.data!;

        return SafeArea(
          child: ListView.separated(
            itemCount: bookings.length,
            padding: EdgeInsets.all(16.w),
            clipBehavior: Clip.none,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 16.h);
            },
            itemBuilder: (BuildContext context, int index) {
              var booking = bookings[index];

              return VenueBookingItemWidget(booking: booking);
            },
          ),
        );
      },
    );
  }
}

class VenueBookingItemWidget extends StatelessWidget {
  const VenueBookingItemWidget({
    super.key,
    required this.booking,
  });

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        Routes.bookingDetail.replaceFirst(':venueId', booking.venueId!).replaceFirst(':bookingId', booking.id!),
      ),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        clipBehavior: Clip.none,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            AppShadow.softShadow,
          ],
        ),
        child: EKAutoLayout(
          direction: EKAutoLayoutDirection.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EKAutoLayout(
              padding: EdgeInsets.all(12.w),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              gap: 8.h,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: EKAutoLayout(
                        direction: EKAutoLayoutDirection.vertical,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        gap: 4.h,
                        children: [
                          // Venue Name
                          Text(
                            booking.unit?.name ?? "Unknown Unit",
                            style: AppTypography.bodyMedium.bold.copyWith(color: AppColor.neutralColor.shade100),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          Text(
                            AppService.instance.unitTypes.firstWhere((element) => element.id == booking.unit?.type).name,
                            style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade60),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Chip(
                      label: Text(booking.status!.toDisplayString()),
                    ),
                  ],
                ),

                // Contact Info
                EKAutoLayout(
                  direction: EKAutoLayoutDirection.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  gap: 8.w,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Symbols.person_rounded,
                            size: AppTypography.bodySmall.medium.fontSize,
                            color: AppColor.primaryColor.main,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            booking.customer!.name,
                            style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade80),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Symbols.phone_rounded,
                            size: AppTypography.bodySmall.medium.fontSize,
                            color: AppColor.primaryColor.main,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            booking.customer!.phoneNumber,
                            style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade100),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Date and Time
                EKAutoLayout(
                  direction: EKAutoLayoutDirection.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  gap: 8.w,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Symbols.calendar_month_rounded,
                            size: AppTypography.bodySmall.medium.fontSize,
                            color: AppColor.primaryColor.main,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            DateFormat("EE, dd MMM yyyy").format(booking.startTime!.toDate()),
                            style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade80),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Symbols.schedule_rounded,
                            size: AppTypography.bodySmall.medium.fontSize,
                            color: AppColor.primaryColor.main,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            DateFormat("h:mm aa - ").format(booking.startTime!.toDate()),
                            style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade100),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            DateFormat("h:mm aa").format(booking.endTime!.toDate()),
                            style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade100),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
