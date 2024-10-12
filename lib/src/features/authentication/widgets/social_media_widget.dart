import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/assets.gen.dart';
import '../../../shared/components/button.dart';
import '../../../shared/layouts/ek_auto_layout.dart';

class SocialAuthWidget extends StatelessWidget {
  const SocialAuthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EKAutoLayout(
      direction: EKAutoLayoutDirection.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      gap: 16.w,
      children: [
        IconButtonComponent(
          onPressed: () {},
          type: ButtonType.outline,
          label: Assets.svgs.icGoogle.svg(),
        ),
        IconButtonComponent(
          onPressed: null,
          type: ButtonType.outline,
          label: Assets.svgs.icApple.svg(),
        ),
        IconButtonComponent(
          onPressed: null,
          type: ButtonType.outline,
          label: Assets.svgs.icFacebook.svg(),
        ),
      ],
    );
  }
}
