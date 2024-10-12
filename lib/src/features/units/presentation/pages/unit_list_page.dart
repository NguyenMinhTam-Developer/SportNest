import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/design/color.dart';
import '../../../../core/design/shadow.dart';
import '../../../../core/design/typography.dart';
import '../../../../core/routes/pages.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../services/app_service.dart';
import '../../../../shared/extensions/hardcode.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../../../../shared/widgets/list_indicators.dart';
import '../controllers/unit_list_page_controller.dart';

class UnitListPage extends GetView<UnitListPageController> {
  const UnitListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnitListPageController>(
      builder: (controller) {
        return FutureBuilder<List<UnitModel>>(
          future: controller.fetchUnitListFuture,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Units'.isHardcoded),
                actions: snapshot.hasData
                    ? [
                        IconButton(
                          icon: const Icon(Symbols.add_rounded),
                          tooltip: 'Add Unit'.isHardcoded,
                          onPressed: () => Get.toNamed(Routes.unitCreate.replaceFirst(':id', snapshot.requireData.first.venueId)),
                        ),
                      ]
                    : null,
              ),
              body: SafeArea(
                child: UnitListWidget(
                  future: controller.fetchUnitListFuture,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class UnitListWidget extends StatelessWidget {
  const UnitListWidget({
    super.key,
    required this.future,
  });

  final Future<List<UnitModel>>? future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UnitModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return ListIndicator(
            icon: Symbols.error_rounded,
            label: "Failed to load unit".isHardcoded,
          );
        }

        if (snapshot.data!.isEmpty) {
          return ListIndicator(
            icon: Symbols.category_rounded,
            label: "You don't have any unit".isHardcoded,
          );
        }

        var units = snapshot.data!;

        return ListView.separated(
          itemCount: units.length,
          padding: EdgeInsets.all(16.w),
          clipBehavior: Clip.none,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 16.h);
          },
          itemBuilder: (BuildContext context, int index) {
            var unit = units[index];

            return UnitItemWidget(
              unit: unit,
            );
          },
        );
      },
    );
  }
}

class UnitItemWidget extends GetWidget<UnitListPageController> {
  const UnitItemWidget({
    super.key,
    required this.unit,
  });

  final UnitModel unit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.unitDetail, parameters: {"unitId": unit.id}),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        clipBehavior: Clip.none,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            AppShadow.softShadow,
          ],
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
                Symbols.category_rounded,
                size: 48.w,
                color: AppColor.primaryColor.main,
              ),
            ),
            Expanded(
              child: EKAutoLayout(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                height: 84.w,
                gap: 8.h,
                children: [
                  Text(
                    unit.name,
                    style: AppTypography.bodyMedium.bold.copyWith(color: AppColor.neutralColor.shade100),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    AppService.instance.unitTypes.firstWhereOrNull((element) => element.id == unit.type)?.name ?? 'Unknown Type',
                    style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade60),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    CurrencyFormatter.format(
                      unit.price,
                      const CurrencyFormat(symbol: '\$'),
                    ),
                    style: AppTypography.bodyMedium.bold.copyWith(color: AppColor.primaryColor.main),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
