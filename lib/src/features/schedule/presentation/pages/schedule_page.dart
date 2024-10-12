import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../controllers/schedule_page_controller.dart';

class SchedulePage extends GetWidget<SchedulePageController> {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchedulePageController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Schedule'),
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
            child: Text('Schedule Page'),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'add_schedule',
            onPressed: () {},
            tooltip: "Add new schedule",
            child: const Icon(Symbols.add_rounded),
          ),
        );
      },
    );
  }
}
