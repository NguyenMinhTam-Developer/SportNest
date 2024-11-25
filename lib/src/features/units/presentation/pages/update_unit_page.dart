import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../controllers/application_controller.dart';

import '../../../../core/design/shadow.dart';
import '../../../../shared/components/button.dart';
import '../../../../shared/components/input_label.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../../../../shared/layouts/page_loading_indicator.dart';
import '../controllers/update_unit_page_controller.dart';

class UpdateUnitPage extends GetView<UpdateUnitPageController> {
  const UpdateUnitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateUnitPageController>(builder: (controller) {
      return PageLoadingIndicator(
        focedLoading: controller.isLoading,
        scaffold: Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.update_unit.tr)),
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
                    labelText: LocaleKeys.slot_name.tr,
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: "name",
                      initialValue: controller.initialUnit.name,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.enter_slot_name.tr,
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ),
                  InputLabel(
                    labelText: LocaleKeys.price.tr,
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: "price",
                      initialValue: controller.initialUnit.price.toString(),
                      decoration: InputDecoration(
                        hintText: LocaleKeys.enter_slot_price.tr,
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ),
                  InputLabel(
                    labelText: LocaleKeys.type.tr,
                    isRequired: true,
                    child: FormBuilderDropdown<String>(
                      name: "type",
                      initialValue: controller.initialUnit.type,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.select_slot_type.tr,
                      ),
                      items: ApplicationController.instance.unitTypes.value
                          .map((type) => DropdownMenuItem(
                                value: type.id,
                                child: Text(type.localeName),
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
                label: LocaleKeys.update.tr,
              ),
            ),
          ),
        ),
      );
    });
  }
}
