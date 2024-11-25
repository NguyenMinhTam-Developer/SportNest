import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';

import '../../../../generated/assets.gen.dart';
import '../../../core/design/color.dart';
import '../../../core/design/typography.dart';
import '../../../shared/components/button.dart';
import '../../../shared/layouts/ek_auto_layout.dart';

class SocialAuthWidget extends StatelessWidget {
  const SocialAuthWidget({
    super.key,
    required this.onSignInWithGoogle,
  });

  final VoidCallback onSignInWithGoogle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EKAutoLayout(
          direction: EKAutoLayoutDirection.horizontal,
          gap: 24.w,
          children: [
            const Expanded(child: Divider()),
            Text(
              LocaleKeys.or_sign_in_with.tr,
              style: AppTypography.bodyMedium.medium.copyWith(color: AppColor.neutralColor.shade60),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        SizedBox(height: 24.h),
        EKAutoLayout(
          direction: EKAutoLayoutDirection.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          gap: 16.w,
          children: [
            IconButtonComponent(
              onPressed: onSignInWithGoogle,
              type: ButtonType.outline,
              label: Assets.svgs.icGoogle.svg(),
            ),
            // IconButtonComponent(
            //   onPressed: null,
            //   type: ButtonType.outline,
            //   label: Assets.svgs.icApple.svg(),
            // ),
            // IconButtonComponent(
            //   onPressed: null,
            //   type: ButtonType.outline,
            //   label: Assets.svgs.icFacebook.svg(),
            // ),
          ],
        ),
      ],
    );
  }
}
