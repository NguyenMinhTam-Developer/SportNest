import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../data/models/receipt_model.dart';
import '../../../../shared/components/button.dart';
import '../../../../shared/extensions/x_datetime.dart';
import '../../../../shared/extensions/x_number.dart';
import '../../../../../generated/locales.g.dart';

import '../../../../core/design/color.dart';
import '../../../../core/design/shadow.dart';
import '../../../../core/design/typography.dart';
import '../../../../core/routes/pages.dart';
import '../../../../data/enums/booking_status_enum.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../../../../shared/widgets/list_indicators.dart';
import '../controllers/booking_detail_page_controller.dart';

class BookingDetailPage extends GetView<BookingDetailPageController> {
  const BookingDetailPage({super.key});

  void _onBookingStatusEditPressed(BuildContext context, BookingModel booking) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              LocaleKeys.update_booking_status.tr,
              style: AppTypography.heading6.semiBold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ...BookingStatusEnum.values.map((status) => ListTile(
                  leading: Icon(status.icon),
                  title: Text(status.toDisplayString()),
                  onTap: () {
                    controller.updateBookingStatus(status);
                    Get.back();
                  },
                  selected: booking.status == status,
                )),
            SizedBox(height: 16.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailPageController>(
      builder: (controller) {
        return FutureBuilder<BookingModel>(
          future: controller.fetchBookingFuture,
          builder: (context, snapshot) => Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  Get.back(result: controller.isUpdated);
                },
              ),
              title: Text(LocaleKeys.booking_detail.tr),
              actions: snapshot.connectionState == ConnectionState.waiting
                  ? null
                  : [
                      if ((snapshot.data?.receipt?.status ?? ReceiptStatus.pending) != ReceiptStatus.paid)
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
                                var result = await Get.toNamed(
                                  Routes.bookingEdit.replaceFirst(':bookingId', snapshot.requireData.id!).replaceFirst(':venueId', snapshot.requireData.venueId!),
                                  arguments: snapshot.requireData,
                                );

                                if (result == true) {
                                  controller.isUpdated = true;
                                  controller.fetchBooking(snapshot.requireData.id!);
                                }
                                break;
                              case "delete":
                                Get.dialog(AlertDialog(
                                  title: Text(
                                    LocaleKeys.delete_booking.tr,
                                    style: AppTypography.heading5.semiBold,
                                  ),
                                  content: Text(
                                    LocaleKeys.are_you_sure_you_want_to_delete_this_booking.tr,
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
                                        controller.deleteBooking(snapshot.requireData);
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
                    label: LocaleKeys.failed_to_load_booking_detail.tr,
                  );
                }

                var booking = snapshot.requireData;

                return SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Venue Name
                      Text(
                        booking.venue!.name,
                        style: AppTypography.heading5.semiBold.copyWith(color: AppColor.neutralColor.shade100),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 8.h),

                      // Unit Name
                      Text(
                        booking.unit!.name,
                        style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 8.h),

                      // Total Amount
                      Text(
                        booking.price?.toCurrency() ?? '0',
                        style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 40.h),

                      // Schedule
                      Text(
                        LocaleKeys.status.tr,
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
                                  booking.status.icon,
                                  size: 20.w,
                                  color: AppColor.neutralColor.shade60,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: InkWell(
                                    onTap: () => _onBookingStatusEditPressed(context, booking),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${LocaleKeys.status.tr}:",
                                          style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              booking.status.toDisplayString(),
                                              style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                            ),
                                            const SizedBox(width: 16),
                                            Icon(
                                              Symbols.edit_rounded,
                                              size: 20.w,
                                              color: AppColor.neutralColor.shade60,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Icon(
                                  Symbols.paid_rounded,
                                  size: 20.w,
                                  color: AppColor.neutralColor.shade60,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${LocaleKeys.payment.tr}:",
                                        style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 2.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: ReceiptStatus.backgroundColor(booking.receipt?.status),
                                              borderRadius: BorderRadius.circular(9999.r),
                                              border: Border.all(
                                                color: ReceiptStatus.borderColor(booking.receipt?.status),
                                                width: 1.w,
                                              ),
                                            ),
                                            child: Text(
                                              ReceiptStatus.label(booking.receipt?.status),
                                              style: AppTypography.bodySmall.medium.copyWith(
                                                color: ReceiptStatus.foregroundColor(booking.receipt?.status),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Schedule
                      Text(
                        LocaleKeys.schedule.tr,
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
                                  booking.startTime!.toDate().formatDate(),
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
                                  "${booking.startTime!.toDate().formatTime()} - ${booking.endTime!.toDate().formatTime()}",
                                  style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Contact
                      Text(
                        LocaleKeys.contact.tr,
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
                                  Symbols.person_rounded,
                                  size: 20.w,
                                  color: AppColor.neutralColor.shade60,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  booking.customer?.name ?? LocaleKeys.walk_in_customer.tr,
                                  style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                ),
                              ],
                            ),
                            if (booking.customer != null) ...[
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
                                    booking.customer?.phoneNumber ?? '',
                                    style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            bottomNavigationBar: snapshot.data != null
                ? SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ButtonComponent.primary(
                          onPressed: () {
                            if (snapshot.data!.receipt != null) {
                              Get.toNamed(Routes.receiptDetail.replaceFirst(':receiptId', snapshot.data!.receipt!.id));
                            } else {
                              controller.onCreateReceiptPressed(snapshot.requireData);
                            }
                          },
                          label: snapshot.data!.receipt == null ? LocaleKeys.create_receipt.tr : LocaleKeys.view_receipt.tr,
                        ),
                      ],
                    ).paddingAll(16.w),
                  )
                : null,
          ),
        );
      },
    );
  }
}
