import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/design/color.dart';
import '../../../../core/design/typography.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../shared/extensions/hardcode.dart';

import '../../../../core/routes/pages.dart';
import '../../../../shared/widgets/list_indicators.dart';
import '../controllers/unit_detail_page_controller.dart';

class UnitDetailPage extends GetView<UnitDetailPageController> {
  const UnitDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnitDetailPageController>(
      builder: (controller) {
        return FutureBuilder<UnitModel>(
          future: controller.fetchUnitFuture,
          builder: (context, snapshot) => Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data?.name ?? ""),
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
                          Routes.unitEdit.replaceFirst(':id', snapshot.requireData.venueId).replaceFirst(':unitId', snapshot.requireData.id),
                          arguments: snapshot.requireData,
                        );
                        break;
                      case "delete":
                        Get.dialog(AlertDialog(
                          title: Text(
                            "Delete Unit".isHardcoded,
                            style: AppTypography.heading5.semiBold,
                          ),
                          content: Text(
                            "Are you sure you want to delete this unit?".isHardcoded,
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
                                controller.deleteUnit();
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
                    label: "Failed to load unit detail".isHardcoded,
                  );
                }

                var unit = snapshot.requireData;

                return SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildInformation(unit),
                    ],
                  ),
                );
              },
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
          unit.price.toStringAsFixed(2),
          style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade60),
        ),
      ],
    );
  }
}
