import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/design/color.dart';
import '../../../../core/design/typography.dart';
import '../../../../core/routes/pages.dart';
import '../../../../shared/layouts/ek_auto_layout.dart';
import '../controllers/profile_page_controller.dart';

class ProfilePage extends GetView<ProfilePageController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfilePageController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: const Icon(Symbols.settings_rounded),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Symbols.notifications_rounded),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Symbols.chat_rounded),
                onPressed: () {},
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: EKAutoLayout(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 8.h,
              children: [
                Text(
                  "Profile",
                  style: AppTypography.bodySmall.medium.copyWith(
                    color: AppColor.neutralColor.shade60,
                  ),
                ).marginSymmetric(horizontal: 16.w),
                EKAutoLayout(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 4.h,
                  children: [
                    ProfileMenuItem(
                      onPressed: () => Get.toNamed(Routes.profileEdit),
                      icon: Symbols.person_rounded,
                      title: "Personal Information",
                    ),
                    ProfileMenuItem(
                      onPressed: () => Get.toNamed(Routes.venues),
                      icon: Symbols.store_rounded,
                      title: "My Venues",
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    this.onPressed,
    required this.icon,
    required this.title,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: EKAutoLayout(
        gap: 16.w,
        direction: EKAutoLayoutDirection.horizontal,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.surface,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              size: 20.w,
              fill: 1,
              color: AppColor.primaryColor.main,
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: AppTypography.bodyMedium.medium.copyWith(
                color: AppColor.neutralColor.shade100,
              ),
            ),
          ),
          Icon(
            Symbols.keyboard_arrow_right_rounded,
            color: AppColor.neutralColor.shade100,
          ),
        ],
      ),
    );
  }
}
