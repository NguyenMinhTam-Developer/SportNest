import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../generated/locales.g.dart';

import '../../../../core/design/color.dart';
import '../../../../core/design/typography.dart';
import '../../../../core/routes/pages.dart';
import '../../../../controllers/authentication_controller.dart';

class ProfilePageController extends GetxController {
  void onPersonalInformationPressed() {
    Get.toNamed(Routes.profileEdit);
  }

  Future<void> onLogoutPressed() async {
    Get.dialog(AlertDialog(
      title: Text(
        LocaleKeys.logout.tr,
        style: AppTypography.heading5.semiBold,
      ),
      content: Text(
        LocaleKeys.are_you_sure_you_want_to_logout.tr,
        style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          style: TextButton.styleFrom(
            foregroundColor: AppColor.neutralColor.shade100,
          ),
          child: Text(LocaleKeys.cancel.tr),
        ),
        FilledButton(
          onPressed: () async {
            Get.back();
            AuthenticationController.instance.signOut();

            Get.offAllNamed(Routes.signIn);
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppColor.errorColor.main,
          ),
          child: Text(LocaleKeys.logout.tr),
        ),
      ],
    ));
  }

  void onLanguagePressed() {
    Get.toNamed(Routes.language);
  }
}

class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePageController>(() => ProfilePageController());
  }
}
