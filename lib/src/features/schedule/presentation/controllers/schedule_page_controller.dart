import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sport_nest_flutter/src/services/authentication_service.dart';
import 'package:sport_nest_flutter/src/shared/extensions/x_datetime.dart';

import '../../../../core/routes/pages.dart';
import '../../../../data/enums/view_mode_enum.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';

class SchedulePageController extends GetxController {
  List<VenueModel> venueList = [];
  List<BookingModel> bookingList = [];

  ViewMode viewMode = ViewMode.day;
  VenueModel? selectedVenue;

  DateTime selectedDate = DateTime.now();
  String get selectedDateString {
    switch (viewMode) {
      case ViewMode.day:
        // if selectedDate is today, return "Today"
        if (selectedDate.isSameDate(DateTime.now())) {
          return "Today";
        }
        return DateFormat('EEEE, MMM d').format(selectedDate);
      case ViewMode.week:
        final firstDayOfWeek = selectedDate.firstDayOfWeek;
        final lastDayOfWeek = selectedDate.lastDayOfWeek;
        return '${DateFormat('MMM d').format(firstDayOfWeek)} - ${DateFormat('MMM d').format(lastDayOfWeek)}';
      case ViewMode.month:
        final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
        final lastDayOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);
        return '${DateFormat('MMM d').format(firstDayOfMonth)} - ${DateFormat('MMM d').format(lastDayOfMonth)}, ${selectedDate.year}';
    }
  }

  Future<void> fetchVenueList() async {
    venueList = await FirebaseFirestoreSource().fetchVenueList(AuthService.instance.currentUser!.uid);
    update();
  }

  Future<void> fetchBookingList() async {
    DateTime from;
    DateTime to;

    switch (viewMode) {
      case ViewMode.day:
        from = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
        to = DateTime(selectedDate.year, selectedDate.month, selectedDate.day + 1);
        break;
      case ViewMode.week:
        from = selectedDate.firstDayOfWeek;
        to = selectedDate.lastDayOfWeek;
        break;
      case ViewMode.month:
        from = DateTime(selectedDate.year, selectedDate.month, 1);
        to = DateTime(selectedDate.year, selectedDate.month + 1, 0);
        break;
    }

    bookingList = await FirebaseFirestoreSource().fetchBookingList(
      selectedVenue!.id,
      from: Timestamp.fromDate(from),
      to: Timestamp.fromDate(to),
    );

    print("Fetching booking list from $from to $to");
    print("Booking list: ${bookingList.length}");

    for (var booking in bookingList) {
      print(booking.startTime?.toDate());
    }

    update();
  }

  void onPreviousPressed() {
    DateTime newDate;

    switch (viewMode) {
      case ViewMode.day:
        newDate = selectedDate.subtract(const Duration(days: 1));
        break;
      case ViewMode.week:
        newDate = selectedDate.subtract(const Duration(days: 7));
        break;
      case ViewMode.month:
        newDate = DateTime(selectedDate.year, selectedDate.month - 1);
        break;
    }

    onDateSelect(newDate);

    update();
  }

  void onNextPressed() {
    DateTime newDate;

    switch (viewMode) {
      case ViewMode.day:
        newDate = selectedDate.add(const Duration(days: 1));
        break;
      case ViewMode.week:
        newDate = selectedDate.add(const Duration(days: 7));
        break;
      case ViewMode.month:
        newDate = DateTime(selectedDate.year, selectedDate.month + 1);
        break;
    }

    onDateSelect(newDate);

    update();
  }

  void onViewModeChanged(ViewMode viewMode) {
    this.viewMode = viewMode;

    fetchBookingList();

    update();
  }

  void onDateSelect(DateTime date) {
    var oldDate = selectedDate;
    var newDate = date;

    selectedDate = date;

    switch (viewMode) {
      case ViewMode.day:
        fetchBookingList();
        break;
      case ViewMode.week:
        if (oldDate.firstDayOfWeek.day >= newDate.firstDayOfWeek.day && oldDate.lastDayOfWeek.day <= newDate.lastDayOfWeek.day) {
          break;
        }

        fetchBookingList();

        break;
      case ViewMode.month:
        if (oldDate.month != newDate.month) {
          fetchBookingList();
        }
        break;
    }

    update();
  }

  void onDateCellPressed(DateTime date) {
    onViewModeChanged(ViewMode.day);
    onDateSelect(date);
  }

  void onVenueChanged(VenueModel? venue) {
    selectedVenue = venue;

    fetchBookingList();

    update();
  }

  Future<void> onBookingItemPressed(BookingModel booking) async {
    var result = await Get.toNamed(Routes.bookingDetail.replaceAll(':venueId', booking.venueId!).replaceAll(':bookingId', booking.id!));

    print("Return after press booking detail is $result");

    if (result == true) {
      fetchBookingList();
    }
  }

  Future<void> onAddBooking() async {
    var result = await Get.toNamed(Routes.bookingCreate.replaceAll(':venueId', selectedVenue!.id));

    if (result == true) {
      fetchBookingList();
    }
  }

  static SchedulePageController? get instance {
    try {
      return Get.find<SchedulePageController>();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> onInit() async {
    await fetchVenueList();

    selectedDate = DateTime.now();
    selectedVenue = venueList.firstOrNull;

    fetchBookingList();

    super.onInit();
  }
}

class SchedulePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchedulePageController>(() => SchedulePageController());
  }
}
