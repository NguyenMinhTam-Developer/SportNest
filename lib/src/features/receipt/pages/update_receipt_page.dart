import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../controllers/update_receipt_page_controller.dart';

class UpdateReceiptPage extends GetView<UpdateReceiptPageController> {
  const UpdateReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.update_receipt.tr),
      ),
    );
  }
}
