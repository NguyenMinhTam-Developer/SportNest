import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../controllers/customer_page_controller.dart';

class CustomerPage extends GetWidget<CustomerPageController> {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Customer'),
            actions: [
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
          body: const Center(
            child: Text('Customer Page'),
          ),
        );
      },
    );
  }
}
