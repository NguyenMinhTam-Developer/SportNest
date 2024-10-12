import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/design/shadow.dart';
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
    return GetBuilder<UpdateBookingPageController>(builder: (controller) {
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
                    child: FormBuilderDropdown<String>(
                      name: "venueId",
                      initialValue: controller.initialBooking.venueId,
                      decoration: InputDecoration(
                        hintText: "Select venue".isHardcoded,
                      ),
                      items: controller.venues
                          .map((venue) => DropdownMenuItem(
                                value: venue.id,
                                child: Text(venue.name),
                              ))
                          .toList(),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      onChanged: (value) => controller.onVenueChanged(value),
                    ),
                  ),
                  InputLabel(
                    labelText: "Unit".isHardcoded,
                    isRequired: true,
                    child: FormBuilderDropdown<String>(
                      name: "unitId",
                      initialValue: controller.initialBooking.unitId,
                      decoration: InputDecoration(
                        hintText: "Select unit".isHardcoded,
                      ),
                      items: controller.units
                          .map((unit) => DropdownMenuItem(
                                value: unit.id,
                                child: Text(unit.name),
                              ))
                          .toList(),
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
                            initialValue: controller.initialBooking.startTime,
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
                            initialValue: controller.initialBooking.endTime,
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
                    labelText: "Contact Name".isHardcoded,
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: "contactName",
                      initialValue: controller.initialBooking.contactName,
                      decoration: InputDecoration(
                        hintText: "Enter contact name".isHardcoded,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ),
                  InputLabel(
                    labelText: "Phone Number".isHardcoded,
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: "phoneNumber",
                      initialValue: controller.initialBooking.phoneNumber,
                      decoration: InputDecoration(
                        hintText: "Enter phone number".isHardcoded,
                      ),
                      keyboardType: TextInputType.phone,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                  ),
                  InputLabel(
                    labelText: "Status".isHardcoded,
                    isRequired: true,
                    child: FormBuilderDropdown<String>(
                      name: "status",
                      initialValue: controller.initialBooking.status,
                      decoration: InputDecoration(
                        hintText: "Select status".isHardcoded,
                      ),
                      items: ['Pending', 'Confirmed', 'Cancelled']
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
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
    });
  }
}
