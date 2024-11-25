import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../generated/locales.g.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../../receipt/pages/receipt_list_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../schedule/presentation/pages/schedule_page.dart';
import '../controllers/home_page_controller.dart';

class HomePage extends GetWidget<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const DashboardPage(),
      const SchedulePage(),
      const ReceiptListPage(),
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
            destinations: [
              NavigationDestination(
                icon: const Icon(Symbols.dashboard_rounded),
                selectedIcon: const Icon(Symbols.dashboard_rounded, fill: 1),
                label: LocaleKeys.dashboard.tr,
              ),
              // NavigationDestination(
              //   icon: Icon(Symbols.chat_rounded),
              //   selectedIcon: Icon(Symbols.chat_rounded, fill: 1),
              //   label: 'Messages',
              // ),
              NavigationDestination(
                icon: const Icon(Symbols.calendar_month_rounded),
                selectedIcon: const Icon(Symbols.calendar_month_rounded, fill: 1),
                label: LocaleKeys.schedule.tr,
              ),
              NavigationDestination(
                icon: const Icon(Symbols.receipt_long_rounded),
                selectedIcon: const Icon(Symbols.receipt_long_rounded, fill: 1),
                label: LocaleKeys.invoices.tr,
              ),
              NavigationDestination(
                icon: const Icon(Symbols.account_circle_rounded),
                selectedIcon: const Icon(Symbols.account_circle_rounded, fill: 1),
                label: LocaleKeys.profile.tr,
              ),
            ],
          ),
        );
      },
    );
  }
}
