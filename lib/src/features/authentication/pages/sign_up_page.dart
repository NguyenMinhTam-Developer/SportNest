import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/design/color.dart';
import '../../../core/design/typography.dart';
import '../../../core/routes/pages.dart';
import '../../../shared/components/button.dart';
import '../../../shared/components/input_label.dart';
import '../../../shared/extensions/hardcode.dart';
import '../../../shared/layouts/ek_auto_layout.dart';
import '../../../shared/layouts/page_loading_indicator.dart';
import '../controllers/sign_up_page_controller.dart';
import '../widgets/social_media_widget.dart';

class SignUpPage extends GetWidget<SignUpPageController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpPageController>(builder: (controller) {
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
                  SizedBox(height: 24.h),
                  EKAutoLayout(
                    direction: EKAutoLayoutDirection.horizontal,
                    gap: 24.w,
                    children: [
                      const Expanded(child: Divider()),
                      Text(
                        "Or Sign in with".isHardcoded,
                        style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  const SocialAuthWidget(),
                  SizedBox(height: 24.h),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Already a member? ".isHardcoded,
                      style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade100),
                      children: [
                        TextSpan(
                          text: "Sign In".isHardcoded,
                          style: AppTypography.bodyMedium.semiBold.copyWith(color: AppColor.primaryColor.main),
                          recognizer: TapGestureRecognizer()..onTap = () => Get.offNamed(Routes.signIn),
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
    });
  }

  Widget _buildForm() {
    return FormBuilder(
      key: controller.formKey,
      autovalidateMode: controller.autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputLabel(
            labelText: "Email".isHardcoded,
            child: FormBuilderTextField(
              name: "email",
              decoration: InputDecoration(
                hintText: "Enter your email".isHardcoded,
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
            labelText: "Username".isHardcoded,
            child: FormBuilderTextField(
              name: "username",
              decoration: InputDecoration(
                hintText: "Enter your username".isHardcoded,
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
          ),
          SizedBox(height: 16.h),
          InputLabel(
            labelText: "Password".isHardcoded,
            child: FormBuilderTextField(
              name: "password",
              obscureText: controller.obscureText,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: "Enter your password".isHardcoded,
                suffixIcon: IconButton(
                  onPressed: controller.onPasswordVisibilityPressed,
                  icon: Icon(
                    controller.obscureText ? Symbols.visibility_off_rounded : Symbols.visibility_rounded,
                    color: AppColor.neutralColor.shade60,
                  ),
                ),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(6),
              ]),
            ),
          ),
          SizedBox(height: 16.h),
          EKAutoLayout(
            direction: EKAutoLayoutDirection.horizontal,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            gap: 8.w,
            children: [
              SizedBox(
                width: 20.w,
                height: 20.w,
                child: Checkbox(
                  value: controller.isAgree,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: AppColor.primaryColor.main,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                  side: BorderSide(color: AppColor.neutralColor.shade40, width: 1.w, strokeAlign: BorderSide.strokeAlignInside),
                  onChanged: controller.onAgreePressed,
                ),
              ),
              Expanded(
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: "I Agree with ".isHardcoded,
                    style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade100),
                    children: [
                      TextSpan(
                        text: "Terms of Service".isHardcoded,
                        style: AppTypography.bodyMedium.semiBold.copyWith(color: AppColor.primaryColor.main),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: " and ".isHardcoded,
                        style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade100),
                      ),
                      TextSpan(
                        text: "Privacy Policy".isHardcoded,
                        style: AppTypography.bodyMedium.semiBold.copyWith(color: AppColor.primaryColor.main),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          ButtonComponent.primary(
            onPressed: controller.isAgree ? controller.onSubmitPressed : null,
            label: "Register".isHardcoded,
          ),
        ],
      ),
    );
  }

  Column _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Getting started!".isHardcoded,
          style: AppTypography.heading5.semiBold,
        ),
        SizedBox(height: 8.h),
        Text(
          "Create account to start using Sport Nest".isHardcoded,
          style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
        ),
      ],
    );
  }
}
