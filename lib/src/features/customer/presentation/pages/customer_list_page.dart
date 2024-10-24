import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/design/color.dart';
import '../../../../core/design/typography.dart';
import '../../../../core/routes/pages.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../shared/extensions/hardcode.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../../../../shared/widgets/list_indicators.dart';
import '../controllers/customer_list_page_controller.dart';

class CustomerListPage extends GetView<CustomerListPageController> {
  const CustomerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerListPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Customers'.isHardcoded),
            actions: [
              IconButton(
                icon: const Icon(Symbols.person_add_alt_rounded),
                tooltip: 'Add Customer'.isHardcoded,
                onPressed: controller.onAddCustomerPressed,
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(56.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: TextField(
                  onChanged: controller.searchCustomers,
                  decoration: InputDecoration(
                    hintText: 'Search name or phone number'.isHardcoded,
                    prefixIcon: const Icon(Symbols.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: CustomerListWidget(
              customers: controller.filteredCustomers,
            ),
          ),
        );
      },
    );
  }
}

class CustomerListWidget extends StatelessWidget {
  const CustomerListWidget({
    super.key,
    required this.customers,
  });

  final RxList<CustomerModel> customers;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerListPageController>(
      builder: (controller) {
        return FutureBuilder<List<CustomerModel>>(
          future: controller.fetchCustomerListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return ListIndicator(
                icon: Symbols.error_rounded,
                label: "Failed to load customers".isHardcoded,
              );
            }

            return Obx(() {
              if (customers.isEmpty) {
                return ListIndicator(
                  icon: Symbols.person_rounded,
                  label: "No customers found".isHardcoded,
                );
              }

              return ListView.separated(
                itemCount: customers.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 16.h);
                },
                itemBuilder: (BuildContext context, int index) {
                  var customer = customers[index];
                  return CustomerItemWidget(
                    customer: customer,
                  );
                },
              );
            });
          },
        );
      },
    );
  }
}

class CustomerItemWidget extends GetWidget<CustomerListPageController> {
  const CustomerItemWidget({
    super.key,
    required this.customer,
  });

  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: controller.isSelectMode ? () => Get.back(result: customer) : null,
      child: EKAutoLayout(
        gap: 8.w,
        padding: EdgeInsets.all(16.w),
        direction: EKAutoLayoutDirection.horizontal,
        children: [
          Container(
            height: 40.w,
            width: 40.w,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.08)),
              color: const Color(0xFFF5F5F5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Symbols.person_rounded,
              size: 24.w,
              color: const Color(0xFF717680),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  customer.name,
                  style: AppTypography.bodyMedium.semiBold,
                ),
                Text(
                  customer.phoneNumber,
                  style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade60),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () => Get.toNamed(Routes.customerDetail.replaceFirst(':customerId', customer.id)),
            icon: const Icon(Symbols.keyboard_arrow_right_rounded),
          ),
        ],
      ),
    );
  }
}
