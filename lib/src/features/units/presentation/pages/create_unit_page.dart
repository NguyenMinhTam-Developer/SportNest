import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sport_nest_flutter/src/services/app_service.dart';

import '../../../../core/design/shadow.dart';
import '../../../../shared/components/button.dart';
import '../../../../shared/components/input_label.dart';
import '../../../../shared/extensions/hardcode.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../../../../shared/layouts/page_loading_indicator.dart';
import '../controllers/create_unit_page_controller.dart';

class CreateUnitPage extends GetView<CreateUnitPageController> {
  const CreateUnitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateUnitPageController>(builder: (controller) {
      return PageLoadingIndicator(
        focedLoading: controller.isLoading,
        scaffold: Scaffold(
          appBar: AppBar(title: Text('Create Unit'.isHardcoded)),
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
                      decoration: InputDecoration(
                        hintText: "Enter unit name".isHardcoded,
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ),
                  InputLabel(
                    labelText: "Price".isHardcoded,
                    isRequired: true,
                    child: FormBuilderTextField(
                      name: "price",
                      decoration: InputDecoration(
                        hintText: "Enter unit price".isHardcoded,
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                  ),
                  InputLabel(
                    labelText: "Type".isHardcoded,
                    isRequired: true,
                    child: FormBuilderDropdown<String>(
                      name: "type",
                      initialValue: AppService.instance.unitTypes.firstOrNull?.id,
                      decoration: InputDecoration(
                        hintText: "Select unit type".isHardcoded,
                      ),
                      items: AppService.instance.unitTypes
                          .map((type) => DropdownMenuItem(
                                value: type.id,
                                child: Text(type.name),
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
                label: "Create Unit".isHardcoded,
              ),
            ),
          ),
        ),
      );
    });
  }
}
