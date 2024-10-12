import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/splash_page_controller.dart';

class SplashPage extends GetWidget<SplashPageController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashPageController>(
      builder: (_) {
        return Scaffold(
          body: Center(
            child: FlutterLogo(
              size: 100.w,
            ),
          ),
        );
      },
    );
  }
}
