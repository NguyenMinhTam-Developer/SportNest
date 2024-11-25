import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../generated/assets.gen.dart';

import '../controllers/splash_page_controller.dart';

class SplashPage extends GetWidget<SplashPageController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashPageController>(
      builder: (_) {
        return Scaffold(
          body: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Assets.logo.sportNestLogoSquare.image(
                width: Get.size.width * 0.30,
                height: Get.size.width * 0.30,
              ),
            ),
          ),
        );
      },
    );
  }
}
