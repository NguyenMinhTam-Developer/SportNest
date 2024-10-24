import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sport_nest_flutter/src/services/authentication_service.dart';
import 'package:intl/intl.dart';

import '../../../../data/enums/view_mode_enum.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';

class SchedulePageController extends GetxController {
  VenueModel? selectedVenue;
  List<VenueModel> venueList = [];
  ViewMode viewMode = ViewMode.day;
  IconData get viewModeIcon {
    switch (viewMode) {
      case ViewMode.day:
        return Symbols.calendar_view_day_rounded;
      case ViewMode.week:
        return Symbols.calendar_view_week_rounded;
      case ViewMode.month:
        return Symbols.calendar_view_month_rounded;
    }
  }

  DateTime selectedDate = DateTime.now();

  String get selectedDateString {
    final now = DateTime.now();
    final selected = selectedDate;

    switch (viewMode) {
      case ViewMode.day:
        if (selected.year == now.year && selected.month == now.month && selected.day == now.day) {
          return "Today";
        }
        return DateFormat('EEEE, MMMM d, yyyy').format(selected);
      case ViewMode.week:
        final startOfWeek = selected.subtract(Duration(days: selected.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));

        if (startOfWeek.isAtSameMomentAs(now.subtract(Duration(days: now.weekday - 1)))) {
          return "This Week";
        }

        return "${DateFormat('MMM d').format(startOfWeek)} - ${DateFormat('MMM d, yyyy').format(endOfWeek)}";
      case ViewMode.month:
        if (selected.year == now.year && selected.month == now.month) {
          return "This Month";
        }
        return DateFormat('MMMM yyyy').format(selected);
    }
  }

  List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<(DateTime, List<BookingModel>)> displayDateList = [];

  bool isLoadingBookings = false;

  void onPreviousPressed() {
    switch (viewMode) {
      case ViewMode.day:
        setSelectedDate(selectedDate.subtract(const Duration(days: 1)));
        break;
      case ViewMode.week:
        setSelectedDate(selectedDate.subtract(const Duration(days: 7)));
        break;
      case ViewMode.month:
        setSelectedDate(selectedDate.subtract(const Duration(days: 1)));
        break;
    }
  }

  void onNextPressed() {
    switch (viewMode) {
      case ViewMode.day:
        setSelectedDate(selectedDate.add(const Duration(days: 1)));
        break;
      case ViewMode.week:
        setSelectedDate(selectedDate.add(const Duration(days: 7)));
        break;
      case ViewMode.month:
        setSelectedDate(DateTime(selectedDate.year, selectedDate.month + 1, 1));
        break;
    }

    update();
  }

  Future<void> onDateSelect() async {
    final firstDate = DateTime.now().subtract(const Duration(days: 365 * 3));
    final lastDate = DateTime.now().add(const Duration(days: 365 * 3));

    var result = await Get.dialog(
      DatePickerDialog(
        initialDate: selectedDate,
        firstDate: firstDate,
        lastDate: lastDate,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
      ),
    );

    if (result != null) {
      setSelectedDate(result);
    }
  }

  void setViewMode(ViewMode mode) {
    viewMode = mode;
    updateDisplayDateList();
    update();
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    updateDisplayDateList();
    update();
  }

  Future<void> updateDisplayDateList() async {
    List<DateTime> dates = [];
    DateTime startDate;
    DateTime endDate;

    switch (viewMode) {
      case ViewMode.day:
        dates = [selectedDate];
        startDate = selectedDate;
        endDate = selectedDate.add(const Duration(days: 1));
        break;
      case ViewMode.week:
        startDate = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
        endDate = startDate.add(const Duration(days: 7));
        dates = List.generate(7, (index) => startDate.add(Duration(days: index)));
        break;
      case ViewMode.month:
        final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
        final lastDayOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);
        startDate = firstDayOfMonth;
        endDate = lastDayOfMonth;

        int daysFromPreviousMonth = firstDayOfMonth.weekday - 1;
        int daysFromNextMonth = 42 - (daysFromPreviousMonth + lastDayOfMonth.day);

        dates = [
          ...List.generate(daysFromPreviousMonth, (index) => firstDayOfMonth.subtract(Duration(days: daysFromPreviousMonth - index))),
          ...List.generate(lastDayOfMonth.day, (index) => DateTime(firstDayOfMonth.year, firstDayOfMonth.month, index + 1)),
          ...List.generate(daysFromNextMonth, (index) => lastDayOfMonth.add(Duration(days: index + 1))),
        ];
        break;
    }

    assert(dates.length == 42 || dates.length == 7 || dates.length == 1, "displayDateList should contain 42 dates for month view, 7 for week view, or 1 for day view");

    isLoadingBookings = true;
    update(); // Trigger UI update with dates and loading state

    // Fetch bookings
    List<BookingModel> bookings = await FirebaseFirestoreSource().fetchBookingList(
      selectedVenue!.id,
      from: Timestamp.fromDate(startDate),
      to: Timestamp.fromDate(endDate),
    );

    // Update displayDateList with fetched bookings
    displayDateList = dates.map((date) => (date, _getBookingsForDate(date, bookings))).toList();

    isLoadingBookings = false;
    update(); // Trigger UI update with bookings and loading state
  }

  List<BookingModel> _getBookingsForDate(DateTime date, List<BookingModel> bookings) {
    return bookings.where((booking) {
      final bookingDate = booking.startTime!.toDate();
      return bookingDate.year == date.year && bookingDate.month == date.month && bookingDate.day == date.day;
    }).toList();
  }

  Future<void> _fetchVenueList() async {
    venueList = await FirebaseFirestoreSource().fetchVenueList(AuthService.instance.currentUser!.uid);
    update();
  }

  @override
  Future<void> onInit() async {
    await _fetchVenueList();
    selectedVenue = venueList.firstOrNull;
    await updateDisplayDateList();
    super.onInit();
  }
}

class SchedulePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchedulePageController>(() => SchedulePageController());
  }
}
