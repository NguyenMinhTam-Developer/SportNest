import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../schedule/presentation/pages/schedule_page.dart';
import '../controllers/home_page_controller.dart';

class HomePage extends GetWidget<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const DashboardPage(),
      const SizedBox(),
      const SchedulePage(),
      const SizedBox(),
      const ProfilePage(),
    ];

    return GetBuilder<HomePageController>(
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.currentIndex,
            children: List.generate(
              pages.length,
              (index) => pages.elementAt(index),
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: controller.currentIndex,
            onDestinationSelected: controller.changeIndex,
            destinations: const [
              NavigationDestination(
                icon: Icon(Symbols.dashboard_rounded),
                selectedIcon: Icon(Symbols.dashboard_rounded, fill: 1),
                label: 'Dashboard',
              ),
              NavigationDestination(
                icon: Icon(Symbols.chat_rounded),
                selectedIcon: Icon(Symbols.chat_rounded, fill: 1),
                label: 'Messages',
              ),
              NavigationDestination(
                icon: Icon(Symbols.calendar_month_rounded),
                selectedIcon: Icon(Symbols.calendar_month_rounded, fill: 1),
                label: 'Schedule',
              ),
              NavigationDestination(
                icon: Icon(Symbols.notifications_rounded),
                selectedIcon: Icon(Symbols.notifications_rounded, fill: 1),
                label: 'Notifications',
              ),
              NavigationDestination(
                icon: Icon(Symbols.account_circle),
                selectedIcon: Icon(Symbols.account_circle, fill: 1),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
