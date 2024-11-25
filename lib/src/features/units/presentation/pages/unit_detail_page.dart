import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../shared/extensions/x_number.dart';

import '../../../../core/design/color.dart';
import '../../../../core/design/typography.dart';
import '../../../../data/models/unit_model.dart';
import '../controllers/unit_detail_page_controller.dart';

class UnitDetailPage extends GetView<UnitDetailPageController> {
  const UnitDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnitDetailPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(controller.unit?.name ?? ""),
            actions: [
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
                onSelected: (value) {
                  switch (value) {
                    case "edit":
                      controller.onUnitEditPressed();
                      break;
                    case "delete":
                      Get.dialog(AlertDialog(
                        title: Text(
                          LocaleKeys.delete_unit.tr,
                          style: AppTypography.heading5.semiBold,
                        ),
                        content: Text(
                          LocaleKeys.are_you_sure_you_want_to_delete_this_unit.tr,
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
                              controller.deleteUnit();
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
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInformation(controller.unit!),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInformation(UnitModel unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          unit.name,
          style: AppTypography.heading6.bold.copyWith(color: AppColor.neutralColor.shade100),
        ),
        SizedBox(height: 8.h),
        Text(
          unit.price.toCurrency(),
          style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade60),
        ),
      ],
    );
  }
}
