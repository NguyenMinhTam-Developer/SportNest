import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/language_service.dart';

extension XDateTime on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  String formatDate() {
    final languageService = Get.find<LanguageController>();
    return DateFormat.yMMMMEEEEd(languageService.currentLocale.languageCode).format(this);
  }

  String formatTime() {
    final languageService = Get.find<LanguageController>();
    return DateFormat('HH:mm aa', languageService.currentLocale.languageCode).format(this);
  }

  DateTime get firstDayOfWeek {
    return subtract(Duration(days: weekday - 1));
  }

  DateTime get lastDayOfWeek {
    return add(Duration(days: DateTime.daysPerWeek - weekday));
  }

  String getWeekdayName(int index) {
    final date = DateTime.now().subtract(Duration(days: DateTime.now().weekday - index - 1));
    final languageService = Get.find<LanguageController>();
    return DateFormat('EEE', languageService.currentLocale.languageCode).format(date);
  }
}
