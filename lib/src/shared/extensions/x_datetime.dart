import 'package:intl/intl.dart';

extension XDateTime on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  String formatTime() {
    return DateFormat('h:mm a').format(this);
  }

  DateTime get firstDayOfWeek {
    return subtract(Duration(days: weekday - 1));
  }

  DateTime get lastDayOfWeek {
    return add(Duration(days: DateTime.daysPerWeek - weekday));
  }

  String getWeekdayName(int index) {
    final date = DateTime.now().subtract(Duration(days: DateTime.now().weekday - index - 1));
    return DateFormat('EEE').format(date); // 'EEEE' gives the full name of the weekday
  }
}
