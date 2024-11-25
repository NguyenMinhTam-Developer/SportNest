import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../controllers/create_receipt_page_controller.dart';

class CreateReceiptPage extends GetView<CreateReceiptPageController> {
  const CreateReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateReceiptPageController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.create_receipt.tr),
          ),
        );
      },
    );
  }
}
