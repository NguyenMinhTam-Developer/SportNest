import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/design/color.dart';
import '../../../../core/design/shadow.dart';
import '../../../../core/design/typography.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../shared/extensions/hardcode.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../../../../shared/widgets/list_indicators.dart';

import '../../../../core/routes/pages.dart';
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
                          onPressed: () => Get.toNamed(Routes.bookingCreate.replaceFirst(':id', snapshot.requireData.first.venueId)),
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

        return ListView.separated(
          itemCount: bookings.length,
          padding: EdgeInsets.all(16.w),
          clipBehavior: Clip.none,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 16.h);
          },
          itemBuilder: (BuildContext context, int index) {
            var booking = bookings[index];

            return BookingItemWidget(booking: booking);
          },
        );
      },
    );
  }
}

class BookingItemWidget extends StatelessWidget {
  const BookingItemWidget({
    super.key,
    required this.booking,
  });

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        Routes.bookingDetail,
        parameters: {
          'bookingId': booking.id,
          'venueId': booking.venueId,
        },
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
            AspectRatio(
              aspectRatio: 327.w / 209.h,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.surface,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Symbols.category_rounded,
                  size: 48.w,
                  color: AppColor.primaryColor.main,
                ),
              ),
            ),
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
                          booking.venue?.name ?? "Unknown Venue",
                          style: AppTypography.bodyMedium.bold.copyWith(color: AppColor.neutralColor.shade100),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        Text(
                          booking.unit?.name ?? "Unknown Unit",
                          style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade80),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
                    Chip(
                      label: Text(booking.status.isHardcoded),
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
                            booking.contactName,
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
                            booking.phoneNumber,
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
                            DateFormat("EE, dd MMM yyyy").format(booking.startTime),
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
                            DateFormat("h:mm aa - ").format(booking.startTime),
                            style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade100),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            DateFormat("h:mm aa").format(booking.endTime),
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
