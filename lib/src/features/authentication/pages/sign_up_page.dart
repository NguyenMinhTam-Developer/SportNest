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
        future: controller.signUpFuture,
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
                  SocialAuthWidget(
                    onSignInWithGoogle: controller.signInWithGoogle,
                  ),
                  SizedBox(height: 24.h),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "${LocaleKeys.already_a_member.tr} ",
                      style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade100),
                      children: [
                        TextSpan(
                          text: LocaleKeys.sign_in.tr,
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
            labelText: LocaleKeys.username.tr,
            child: FormBuilderTextField(
              name: "username",
              decoration: InputDecoration(
                hintText: LocaleKeys.enter_your_username.tr,
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
            labelText: LocaleKeys.email.tr,
            child: FormBuilderTextField(
              name: "email",
              decoration: InputDecoration(
                hintText: LocaleKeys.enter_your_email.tr,
              ),
              autocorrect: false,
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
              obscureText: controller.obscureText,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: LocaleKeys.enter_your_password.tr,
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
                    text: "${LocaleKeys.i_agree_with.tr}  ",
                    style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade100),
                    children: [
                      TextSpan(
                        text: LocaleKeys.terms_of_service.tr,
                        style: AppTypography.bodyMedium.semiBold.copyWith(color: AppColor.primaryColor.main),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: " ${LocaleKeys.and.tr} ",
                        style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade100),
                      ),
                      TextSpan(
                        text: LocaleKeys.privacy_policy.tr,
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
            label: LocaleKeys.register.tr,
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
          LocaleKeys.getting_started.tr,
          style: AppTypography.heading5.semiBold,
        ),
        SizedBox(height: 8.h),
        Text(
          LocaleKeys.create_account_to_start_using_sport_nest.tr,
          style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
        ),
      ],
    );
  }
}
