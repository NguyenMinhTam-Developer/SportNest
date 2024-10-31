import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../generated/locales.g.dart';
import '../controllers/language_page_controller.dart';

class LanguagePage extends GetView<LanguagePageController> {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.languages.tr),
      ),
      body: GetBuilder<LanguagePageController>(
        builder: (controller) => ListView.separated(
          itemCount: controller.languages.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final language = controller.languages[index];
            final isSelected = controller.currentLanguageCode == language['code'];

            return ListTile(
              title: Text(language['name']!),
              trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
              onTap: () => controller.changeLanguage(
                language['code']!,
                language['country']!,
              ),
            );
          },
        ),
      ),
    );
  }
}
