import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/design/shadow.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../shared/components/button.dart';
import '../../../../shared/components/input_label.dart';
import '../../../../shared/extensions/hardcode.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../../../../shared/layouts/page_loading_indicator.dart';
import '../controllers/update_booking_page_controller.dart';

class UpdateBookingPage extends GetView<UpdateBookingPageController> {
  const UpdateBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateBookingPageController>(
      builder: (controller) {
        return PageLoadingIndicator(
          focedLoading: controller.isLoading,
          scaffold: Scaffold(
            appBar: AppBar(title: Text('Update Booking'.isHardcoded)),
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
                    InputLabel(
                      labelText: "Venue".isHardcoded,
                      isRequired: true,
                      child: FutureBuilder<List<VenueModel>>(
                        future: controller.venues,
                        builder: (context, snapshot) {
                          return FormBuilderDropdown<String>(
                            name: "venueId",
                            initialValue: (snapshot.data ?? []).firstWhereOrNull((element) => element.id == controller.initialBooking.venueId)?.id,
                            decoration: InputDecoration(
                              hintText: "Select venue".isHardcoded,
                            ),
                            items: (snapshot.data ?? [])
                                .map((venue) => DropdownMenuItem(
                                      value: venue.id,
                                      child: Text(venue.name),
                                    ))
                                .toList(),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            onChanged: (value) => controller.onVenueChanged(value),
                          );
                        },
                      ),
                    ),
                    InputLabel(
                      labelText: "Unit".isHardcoded,
                      isRequired: true,
                      child: FutureBuilder<List<UnitModel>>(
                        future: controller.units,
                        builder: (context, snapshot) {
                          return FormBuilderDropdown<String>(
                            name: "unitId",
                            initialValue: (snapshot.data ?? []).firstWhereOrNull((element) => element.id == controller.initialBooking.unitId)?.id,
                            decoration: InputDecoration(
                              hintText: "Select unit".isHardcoded,
                            ),
                            items: (snapshot.data ?? [])
                                .map((unit) => DropdownMenuItem(
                                      value: unit.id,
                                      child: Text(unit.name),
                                    ))
                                .toList(),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          );
                        },
                      ),
                    ),
                    InputLabel(
                      labelText: "Date".isHardcoded,
                      isRequired: true,
                      child: FormBuilderDateTimePicker(
                        name: "date",
                        initialValue: controller.initialBooking.startTime!.toDate(),
                        inputType: InputType.date,
                        // firstDate: DateTime.now(),
                        decoration: InputDecoration(
                          hintText: "Select date".isHardcoded,
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                    ),
                    EKAutoLayout(
                      direction: EKAutoLayoutDirection.horizontal,
                      gap: 16.w,
                      children: [
                        Expanded(
                          child: InputLabel(
                            labelText: "Start Time".isHardcoded,
                            isRequired: true,
                            child: FormBuilderDateTimePicker(
                              name: "startTime",
                              initialValue: controller.initialBooking.startTime!.toDate(),
                              inputType: InputType.time,
                              format: DateFormat("h:mm aa"),
                              decoration: InputDecoration(
                                hintText: "HH:mm".isHardcoded,
                                suffixIcon: const Icon(Symbols.schedule),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InputLabel(
                            labelText: "End Time".isHardcoded,
                            isRequired: true,
                            child: FormBuilderDateTimePicker(
                              name: "endTime",
                              initialValue: controller.initialBooking.endTime!.toDate(),
                              inputType: InputType.time,
                              format: DateFormat("h:mm aa"),
                              decoration: InputDecoration(
                                hintText: "HH:mm".isHardcoded,
                                suffixIcon: const Icon(Symbols.schedule),
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
                      labelText: "Customer".isHardcoded,
                      isRequired: true,
                      child: FormBuilderTextField(
                        name: "contactName",
                        readOnly: true,
                        onTap: () => controller.onCustomerPressed(),
                        decoration: InputDecoration(
                          hintText: "Enter contact name".isHardcoded,
                          suffixIcon: const Icon(Symbols.contacts_rounded),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
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
                  label: "Update Booking".isHardcoded,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
