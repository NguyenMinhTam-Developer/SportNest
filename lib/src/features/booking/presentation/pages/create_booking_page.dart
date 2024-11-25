import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import '../../../../core/design/color.dart';
import '../../../../core/design/typography.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../controllers/application_controller.dart';
import '../../../../core/design/shadow.dart';
import '../../../../shared/components/button.dart';
import '../../../../shared/components/input_label.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../../../../shared/layouts/page_loading_indicator.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../controllers/create_booking_page_controller.dart';

class CreateBookingPage extends GetView<CreateBookingPageController> {
  const CreateBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateBookingPageController>(
      builder: (controller) {
        return PageLoadingIndicator(
          focedLoading: controller.isLoading,
          scaffold: Scaffold(
            appBar: AppBar(title: Text(LocaleKeys.create_booking.tr)),
            body: SingleChildScrollView(
              clipBehavior: Clip.none,
              padding: EdgeInsets.all(16.w),
              child: FormBuilder(
                key: controller.formKey,
                autovalidateMode: controller.autovalidateMode,
                child: EKAutoLayout(
                  gap: 16.h,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Obx(() {
                      return InputLabel(
                        labelText: LocaleKeys.venue.tr,
                        isRequired: true,
                        child: FormBuilderDropdown<String>(
                          name: "venueId",
                          initialValue: controller.initialVenueId,
                          decoration: InputDecoration(
                            hintText: LocaleKeys.select_venue.tr,
                          ),
                          items: ApplicationController.instance.venueList.value.map((venue) => DropdownMenuItem(value: venue.id, child: Text(venue.name))).toList(),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          onChanged: (value) => controller.onVenueChanged(value),
                        ),
                      );
                    }),
                    InputLabel(
                      labelText: LocaleKeys.slots.tr,
                      isRequired: true,
                      child: FormBuilderDropdown<String>(
                        name: "unitId",
                        initialValue: controller.units.firstOrNull?.id,
                        decoration: InputDecoration(
                          hintText: LocaleKeys.select_slot.tr,
                        ),
                        items: controller.units.map((unit) => DropdownMenuItem(value: unit.id, child: Text(unit.name))).toList(),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                    ),
                    InputLabel(
                      labelText: LocaleKeys.date.tr,
                      isRequired: true,
                      child: FormBuilderDateTimePicker(
                        name: "date",
                        initialValue: DateTime.now(),
                        inputType: InputType.date,
                        firstDate: DateTime.now(),
                        decoration: InputDecoration(
                          hintText: LocaleKeys.select_date.tr,
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        format: DateFormat("dd/MM/yyyy"),
                      ),
                    ),
                    EKAutoLayout(
                      direction: EKAutoLayoutDirection.horizontal,
                      gap: 16.w,
                      children: [
                        Expanded(
                          child: InputLabel(
                            labelText: LocaleKeys.start_time.tr,
                            isRequired: true,
                            child: FormBuilderDateTimePicker(
                              name: "startTime",
                              initialValue: DateTime.now().copyWith(hour: DateTime.now().hour, minute: DateTime.now().minute >= 30 ? 30 : 0),
                              inputType: InputType.time,
                              format: DateFormat("h:mm aa"),
                              decoration: const InputDecoration(
                                hintText: "HH:mm",
                                suffixIcon: Icon(Symbols.schedule),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InputLabel(
                            labelText: LocaleKeys.end_time.tr,
                            isRequired: true,
                            child: FormBuilderDateTimePicker(
                              name: "endTime",
                              inputType: InputType.time,
                              initialValue: DateTime.now().copyWith(hour: DateTime.now().hour + 1, minute: DateTime.now().minute >= 30 ? 30 : 0),
                              format: DateFormat("h:mm aa"),
                              decoration: const InputDecoration(
                                hintText: "HH:mm",
                                suffixIcon: Icon(Symbols.schedule),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    InputLabel(
                      labelText: LocaleKeys.customer.tr,
                      isRequired: true,
                      child: FormBuilderTextField(
                        name: "contactName",
                        readOnly: true,
                        enabled: !controller.isWalkInCustomer,
                        onTap: () => controller.onCustomerPressed(),
                        decoration: InputDecoration(
                          hintText: LocaleKeys.enter_contact_name.tr,
                          suffixIcon: const Icon(Symbols.contacts_rounded),
                        ),
                        validator: FormBuilderValidators.compose([
                          if (!controller.isWalkInCustomer) FormBuilderValidators.required(),
                        ]),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: controller.isWalkInCustomer,
                          onChanged: controller.onWalkInCustomerChanged,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          LocaleKeys.walk_in_customer.tr,
                          style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade100),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                boxShadow: [
                  AppShadow.dropShadow,
                ],
              ),
              child: SafeArea(
                child: ButtonComponent.primary(
                  onPressed: controller.onSubmitPressed,
                  label: LocaleKeys.create_booking.tr,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
