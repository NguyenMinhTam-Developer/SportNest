import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/design/color.dart';
import '../../../../core/design/typography.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../shared/extensions/hardcode.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../../../../shared/widgets/list_indicators.dart';
import '../controllers/customer_detail_page_controller.dart';

class CustomerDetailPage extends GetView<CustomerDetailPageController> {
  const CustomerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerDetailPageController>(
      builder: (controller) {
        return FutureBuilder<CustomerModel>(
          future: controller.fetchCustomerFuture,
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
                        controller.onEditPressed(snapshot.requireData);
                        break;
                      case "delete":
                        Get.dialog(AlertDialog(
                          title: Text(
                            "Delete Customer".isHardcoded,
                            style: AppTypography.heading5.semiBold,
                          ),
                          content: Text(
                            "Are you sure you want to delete this customer?".isHardcoded,
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
                                controller.deleteCustomer();
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
                    label: "Failed to load customer detail".isHardcoded,
                  );
                }

                var customer = snapshot.requireData;

                return SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildInformation(customer),
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

  Widget _buildInformation(CustomerModel customer) {
    return EKAutoLayout(
      gap: 16.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildInfoItem("Name".isHardcoded, customer.name),
        _buildInfoItem("Phone".isHardcoded, customer.phoneNumber),
        _buildInfoItem("Email".isHardcoded, customer.email),
        _buildInfoItem("Address".isHardcoded, customer.address),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade60),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: AppTypography.bodyMedium.semiBold.copyWith(color: AppColor.neutralColor.shade100),
        ),
      ],
    );
  }
}
