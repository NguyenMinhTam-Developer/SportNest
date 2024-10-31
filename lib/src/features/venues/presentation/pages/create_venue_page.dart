import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:sport_nest_flutter/generated/locales.g.dart';

import '../../../../core/design/shadow.dart';
import '../../../../shared/components/button.dart';
import '../../../../shared/components/input_label.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../../../../shared/layouts/page_loading_indicator.dart';
import '../controllers/create_venue_page_controller.dart';

class CreateVenuePage extends GetView<CreateVenuePageController> {
  const CreateVenuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateVenuePageController>(builder: (controller) {
      return PageLoadingIndicator(
        focedLoading: controller.isLoading,
        scaffold: Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.createVenue.tr)),
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
                    labelText: LocaleKeys.venueName.tr,
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: "name",
                      decoration: InputDecoration(
                        hintText: LocaleKeys.enterVenueName.tr,
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ),
                  InputLabel(
                    labelText: LocaleKeys.address.tr,
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: "address",
                      decoration: InputDecoration(
                        hintText: LocaleKeys.enterVenueAddress.tr,
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
                          labelText: LocaleKeys.openTime.tr,
                          isRequired: true,
                          child: FormBuilderDateTimePicker(
                            name: "openTime",
                            inputType: InputType.time,
                            format: DateFormat("h:mm aa"),
                            decoration: const InputDecoration(
                              hintText: "HH:mm",
                              suffixIcon: Icon(Symbols.sunny),
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
                          labelText: LocaleKeys.closeTime.tr,
                          isRequired: true,
                          child: FormBuilderDateTimePicker(
                            name: "closeTime",
                            inputType: InputType.time,
                            format: DateFormat("h:mm aa"),
                            decoration: const InputDecoration(
                              hintText: "HH:mm",
                              suffixIcon: Icon(Symbols.bedtime_rounded),
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
                    labelText: LocaleKeys.description.tr,
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: "description",
                      decoration: InputDecoration(
                        hintText: LocaleKeys.enterVenueDescription.tr,
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
                label: LocaleKeys.create.tr,
              ),
            ),
          ),
        ),
      );
    });
  }
}
