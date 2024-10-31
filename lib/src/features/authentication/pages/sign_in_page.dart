import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../generated/locales.g.dart';

import '../../../core/design/color.dart';
import '../../../core/design/typography.dart';
import '../../../core/routes/pages.dart';
import '../../../shared/components/button.dart';
import '../../../shared/components/input_label.dart';
import '../../../shared/layouts/page_loading_indicator.dart';
import '../controllers/sign_in_page_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final controller = Get.find<SignInPageController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInPageController>(
      builder: (controller) {
        return PageLoadingIndicator(
          focedLoading: controller.isLoading,
          scaffold: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(),
                    SizedBox(height: 24.h),
                    _buildForm(),
                    // SizedBox(height: 24.h),
                    // const SocialAuthWidget(),
                    SizedBox(height: 24.h),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: LocaleKeys.notAMember.tr,
                        style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade100),
                        children: [
                          TextSpan(
                            text: LocaleKeys.registerNow.tr,
                            style: AppTypography.bodyMedium.semiBold.copyWith(color: AppColor.primaryColor.main),
                            recognizer: TapGestureRecognizer()..onTap = () => Get.offNamed(Routes.signUp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          LocaleKeys.welcomeBack.tr,
          style: AppTypography.heading5.semiBold,
        ),
        SizedBox(height: 8.h),
        Text(
          LocaleKeys.signInNowToStartUsingSportNest.tr,
          style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return FormBuilder(
      key: controller.formKey,
      autovalidateMode: controller.autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputLabel(
            labelText: LocaleKeys.email.tr,
            child: FormBuilderTextField(
              name: "email",
              decoration: InputDecoration(
                hintText: LocaleKeys.enterYourEmail.tr,
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ]),
            ),
          ),
          SizedBox(height: 16.h),
          InputLabel(
            labelText: LocaleKeys.password.tr,
            child: FormBuilderTextField(
              name: "password",
              decoration: InputDecoration(
                hintText: LocaleKeys.enterYourPassword.tr,
                suffixIcon: IconButton(
                  onPressed: controller.onPasswordVisibilityPressed,
                  icon: Icon(
                    controller.obscureText ? Symbols.visibility_off_rounded : Symbols.visibility_rounded,
                    color: AppColor.neutralColor.shade60,
                  ),
                ),
              ),
              obscureText: controller.obscureText,
              textInputAction: TextInputAction.done,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                LocaleKeys.forgotPassword.tr,
                style: AppTypography.bodyMedium.semiBold.copyWith(color: AppColor.primaryColor.main),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          ButtonComponent.primary(
            onPressed: controller.onSubmitPressed,
            label: LocaleKeys.signIn.tr,
          ),
        ],
      ),
    );
  }
}
