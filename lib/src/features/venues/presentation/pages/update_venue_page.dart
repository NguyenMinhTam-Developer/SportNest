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
import '../controllers/update_venue_page_controller.dart';

class UpdateVenuePage extends GetView<UpdateVenuePageController> {
  const UpdateVenuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateVenuePageController>(builder: (controller) {
      return PageLoadingIndicator(
        focedLoading: controller.isLoading,
        scaffold: Scaffold(
          appBar: AppBar(title: Text('Update Venue'.isHardcoded)),
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
                    labelText: "Name".isHardcoded,
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: "name",
                      initialValue: controller.initialVenue.name,
                      decoration: InputDecoration(
                        hintText: "Enter venue name".isHardcoded,
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ),
                  InputLabel(
                    labelText: "Address".isHardcoded,
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: "address",
                      initialValue: controller.initialVenue.address,
                      decoration: InputDecoration(
                        hintText: "Enter venue address".isHardcoded,
                        suffixIcon: const Icon(Symbols.place_rounded),
                      ),
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
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
                          labelText: "Open Time".isHardcoded,
                          isRequired: true,
                          child: FormBuilderDateTimePicker(
                            name: "openTime",
                            initialValue: controller.initialVenue.openTime,
                            inputType: InputType.time,
                            format: DateFormat("h:mm aa"),
                            decoration: InputDecoration(
                              hintText: "HH:mm".isHardcoded,
                              suffixIcon: const Icon(Symbols.sunny),
                            ),
                            keyboardType: TextInputType.streetAddress,
                            textInputAction: TextInputAction.next,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InputLabel(
                          labelText: "Close Time".isHardcoded,
                          isRequired: true,
                          child: FormBuilderDateTimePicker(
                            name: "closeTime",
                            initialValue: controller.initialVenue.closeTime,
                            inputType: InputType.time,
                            format: DateFormat("h:mm aa"),
                            decoration: InputDecoration(
                              hintText: "HH:mm".isHardcoded,
                              suffixIcon: const Icon(Symbols.bedtime_rounded),
                            ),
                            keyboardType: TextInputType.streetAddress,
                            textInputAction: TextInputAction.next,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InputLabel(
                    labelText: "Description".isHardcoded,
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: "description",
                      initialValue: controller.initialVenue.description,
                      decoration: InputDecoration(
                        hintText: "Enter venue description".isHardcoded,
                      ),
                      minLines: 5,
                      maxLines: 5,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
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
                label: "Update Venue".isHardcoded,
              ),
            ),
          ),
        ),
      );
    });
  }
}
