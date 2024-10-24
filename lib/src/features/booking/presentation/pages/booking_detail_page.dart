import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../data/enums/booking_status_enum.dart';
import '../../../../shared/components/button.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';

import '../../../../core/design/color.dart';
import '../../../../core/design/shadow.dart';
import '../../../../core/design/typography.dart';
import '../../../../core/routes/pages.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../shared/extensions/hardcode.dart';
import '../../../../shared/widgets/list_indicators.dart';
import '../controllers/booking_detail_page_controller.dart';

class BookingDetailPage extends GetView<BookingDetailPageController> {
  const BookingDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailPageController>(
      builder: (controller) {
        return FutureBuilder<BookingModel>(
          future: controller.fetchBookingFuture,
          builder: (context, snapshot) => Scaffold(
            appBar: AppBar(
              title: const Text("Booking Detail"),
              actions: [
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
                        Get.toNamed(
                          Routes.bookingEdit.replaceFirst(':bookingId', snapshot.requireData.id!).replaceFirst(':venueId', snapshot.requireData.venueId!),
                          arguments: snapshot.requireData,
                        );
                        break;
                      case "delete":
                        Get.dialog(AlertDialog(
                          title: Text(
                            "Delete Booking".isHardcoded,
                            style: AppTypography.heading5.semiBold,
                          ),
                          content: Text(
                            "Are you sure you want to delete this booking?".isHardcoded,
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
                                controller.deleteBooking(snapshot.requireData.id!);
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
              ],
            ),
            body: Builder(
              builder: (context) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return ListIndicator(
                    icon: Symbols.error_rounded,
                    label: "Failed to load booking detail".isHardcoded,
                  );
                }

                var booking = snapshot.requireData;

                return SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        booking.venue!.name,
                        style: AppTypography.heading5.semiBold.copyWith(color: AppColor.neutralColor.shade100),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        booking.unit!.name,
                        style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Chip(label: Text(booking.status!.toDisplayString())),
                      SizedBox(height: 40.h),
                      Text(
                        "Schedule".isHardcoded,
                        style: AppTypography.bodyLarge.bold.copyWith(
                          color: AppColor.neutralColor.shade100,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColor.neutralColor.shade10,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            AppShadow.softShadow,
                          ],
                        ),
                        child: EKAutoLayout(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Symbols.calendar_month,
                                  size: 20.w,
                                  color: AppColor.neutralColor.shade60,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  DateFormat('EEEE, MMMM dd, yyyy').format(booking.startTime!.toDate()),
                                  style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Icon(
                                  Symbols.schedule,
                                  size: 20.w,
                                  color: AppColor.neutralColor.shade60,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "${DateFormat('HH:mm aa').format(booking.startTime!.toDate())} - ${DateFormat('HH:mm aa').format(booking.endTime!.toDate())}",
                                  style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Contact".isHardcoded,
                        style: AppTypography.bodyLarge.bold.copyWith(
                          color: AppColor.neutralColor.shade100,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColor.neutralColor.shade10,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            AppShadow.softShadow,
                          ],
                        ),
                        child: EKAutoLayout(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Symbols.calendar_month,
                                  size: 20.w,
                                  color: AppColor.neutralColor.shade60,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  booking.customer!.name,
                                  style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Icon(
                                  Symbols.phone,
                                  size: 20.w,
                                  color: AppColor.neutralColor.shade60,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  booking.customer!.phoneNumber,
                                  style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            bottomNavigationBar: Opacity(
              opacity: snapshot.data?.status == BookingStatusEnum.pending ? 1 : 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ButtonComponent.secondary(
                          onPressed: controller.onRejectPressed,
                          label: "Reject".isHardcoded,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ButtonComponent.primary(
                          onPressed: controller.onConfirmPressed,
                          label: "Confirm".isHardcoded,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
