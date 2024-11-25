import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:sport_nest_flutter/src/controllers/application_controller.dart';
import 'package:sport_nest_flutter/src/core/routes/pages.dart';
import 'package:sport_nest_flutter/src/data/models/receipt_model.dart';
import 'package:sport_nest_flutter/src/shared/extensions/x_number.dart';

import '../../../../generated/locales.g.dart';
import '../../../core/design/color.dart';
import '../../../core/design/shadow.dart';
import '../../../core/design/typography.dart';
import '../../../shared/layouts/ek_auto_layout.dart';
import '../../../shared/widgets/list_indicators.dart';

class ReceiptListPage extends GetView<ApplicationController> {
  const ReceiptListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplicationController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.receipts.tr),
            actions: [
              // IconButton(
              //   icon: const Icon(Symbols.filter_list_rounded),
              //   tooltip: LocaleKeys.filter.tr,
              //   onPressed: () {
              //     // TODO: Implement filter
              //   },
              // ),
            ],
          ),
          body: SafeArea(
            child: Obx(() {
              var receipts = controller.receipts.value;

              if (controller.isFetchingReceiptList.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (receipts.isEmpty) {
                return ListIndicator(
                  icon: Symbols.receipt_rounded,
                  label: LocaleKeys.no_receipts.tr,
                  button: FilledButton(
                    onPressed: () => controller.fetchReceiptList(),
                    child: Text("Refresh"),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.fetchReceiptList(),
                child: ListView.separated(
                  itemCount: receipts.length,
                  padding: EdgeInsets.all(16.w),
                  clipBehavior: Clip.none,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final receipt = receipts[index];
                    return InkWell(
                      onTap: () => Get.toNamed(Routes.receiptDetail.replaceFirst(':receiptId', receipt.id)),
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        clipBehavior: Clip.none,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [AppShadow.softShadow],
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
                                Symbols.receipt_rounded,
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
                                    receipt.booking?.customer?.name ?? LocaleKeys.walk_in_customer.tr,
                                    style: AppTypography.bodyMedium.bold.copyWith(
                                      color: AppColor.neutralColor.shade100,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${receipt.booking?.venue?.name ?? ''} - ${receipt.booking?.unit?.name ?? ''}",
                                    style: AppTypography.bodySmall.medium.copyWith(
                                      color: AppColor.neutralColor.shade60,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  EKAutoLayout(
                                    direction: EKAutoLayoutDirection.horizontal,
                                    gap: 8.w,
                                    children: [
                                      Container(
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
                                      const Spacer(),
                                      Text(
                                        '\$${receipt.totalAmount.toCurrency()}',
                                        style: AppTypography.bodyMedium.bold.copyWith(
                                          color: AppColor.neutralColor.shade100,
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
            }),
          ),
        );
      },
    );
  }
}
