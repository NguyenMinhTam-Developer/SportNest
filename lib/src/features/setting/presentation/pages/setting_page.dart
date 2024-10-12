import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/setting_page_controller.dart';

class SettingPage extends GetView<SettingPageController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
        );
      },
    );
  }
}
