import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../generated/locales.g.dart';
import '../../../core/design/color.dart';
import '../../../core/design/shadow.dart';
import '../../../core/design/typography.dart';
import '../../../data/models/receipt_model.dart';
import '../../../shared/components/button.dart';
import '../../../shared/layouts/ek_auto_layout.dart';
import '../../../shared/widgets/list_indicators.dart';

import '../../../shared/extensions/x_datetime.dart';
import '../../../shared/extensions/x_number.dart';

import '../controllers/receipt_detail_page_controller.dart';

class ReceiptDetailPage extends GetView<ReceiptDetailPageController> {
  const ReceiptDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiptDetailPageController>(builder: (controller) {
      return FutureBuilder<ReceiptModel>(
        future: controller.fetchReceiptFuture,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.receipt_detail.tr),
            ),
            body: Builder(builder: (context) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return ListIndicator(
                  icon: Symbols.error_rounded,
                  label: LocaleKeys.failed_to_load_booking_detail.tr,
                );
              }

              var receipt = snapshot.requireData;

              return SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Venue Name
                    Text(
                      receipt.booking?.venue!.name ?? "",
                      style: AppTypography.heading5.semiBold.copyWith(color: AppColor.neutralColor.shade100),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 8.h),

                    // Unit Name
                    Text(
                      receipt.booking?.venue?.address ?? "",
                      style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 8.h),

                    // Issue Date
                    Text(
                      receipt.issueDate.toDate().formatDate(),
                      style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 8.h),

                    Align(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: ReceiptStatus.backgroundColor(receipt.status),
                          borderRadius: BorderRadius.circular(9999.r),
                          border: Border.all(
                            color: ReceiptStatus.borderColor(receipt.status),
                            width: 1.w,
                          ),
                        ),
                        child: Text(
                          ReceiptStatus.label(receipt.status),
                          style: AppTypography.bodySmall.medium.copyWith(
                            color: ReceiptStatus.foregroundColor(receipt.status),
                          ),
                        ),
                      ),
                    ),

                    // Issue Date
                    if (receipt.status == ReceiptStatus.paid) ...[
                      SizedBox(height: 8.h),
                      Text(
                        receipt.paymentMethod.label,
                        style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                        textAlign: TextAlign.center,
                      ),
                    ],

                    SizedBox(height: 40.h),

                    // Rentail Detail
                    Text(
                      LocaleKeys.rentail_detail.tr,
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
                                receipt.booking?.status.icon,
                                size: 20.w,
                                color: AppColor.neutralColor.shade60,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${LocaleKeys.slot_name.tr}:",
                                      style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                    ),
                                    Text(
                                      receipt.booking?.unit?.name ?? "",
                                      style: AppTypography.bodyMedium.medium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Icon(
                                Symbols.today_rounded,
                                size: 20.w,
                                color: AppColor.neutralColor.shade60,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${LocaleKeys.date.tr}:",
                                      style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          receipt.booking?.startTime!.toDate().formatDate() ?? "",
                                          style: AppTypography.bodyMedium.medium,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Icon(
                                Symbols.schedule_rounded,
                                size: 20.w,
                                color: AppColor.neutralColor.shade60,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${LocaleKeys.start_time.tr}:",
                                      style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          receipt.booking?.timeRange ?? "",
                                          style: AppTypography.bodyMedium.medium,
                                        ),
                                      ],
                                    ),
                                  ],
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
                                      "${LocaleKeys.price.tr}:",
                                      style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                                    ),
                                    Text(
                                      receipt.booking?.price?.toCurrency() ?? "0",
                                      style: AppTypography.bodyMedium.medium.copyWith(),
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

                    // Contact
                    Text(
                      LocaleKeys.customer.tr,
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
                                receipt.booking?.customer?.name ?? LocaleKeys.walk_in_customer.tr,
                                style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                              ),
                            ],
                          ),
                          if (receipt.booking?.customer != null) ...[
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
                                  receipt.booking?.customer?.phoneNumber ?? '',
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
            }),
            bottomNavigationBar: snapshot.data != null && snapshot.requireData.status != ReceiptStatus.paid
                ? SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ButtonComponent.primary(
                          onPressed: controller.onCheckoutPressed,
                          label: LocaleKeys.checkout.tr,
                        ),
                      ],
                    ).paddingAll(16.w),
                  )
                : null,
          );
        },
      );
    });
  }
}
