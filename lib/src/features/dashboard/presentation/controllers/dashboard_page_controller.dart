import 'package:get/get.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../services/authentication_service.dart';
import '../../../../shared/extensions/x_number.dart';

import '../../../../core/routes/pages.dart';
import '../../../../data/enums/payment_status_enum.dart';
import '../../../../data/models/booking_model.dart';

class DashboardPageController extends GetxController {
  List<BookingModel> upcomingBookings = [];
  List<BookingModel> timeFrameBookings = [];
  int selectedTimeFrameIndex = 3;

  static DashboardPageController get instance => Get.find<DashboardPageController>();

  // Computed metrics
  String get totalRevenue {
    final total = timeFrameBookings.fold<double>(
      0.0,
      (sum, booking) => sum + (booking.paymentStatus == PaymentStatusEnum.paid ? (booking.price ?? 0) : 0),
    );
    return total.toCurrency();
  }

  int get totalBookings => timeFrameBookings.length;

  DateTime _getStartDate(int timeFrameIndex) {
    final now = DateTime.now();

    switch (timeFrameIndex) {
      case 0: // Year
        return DateTime(now.year, 1, 1); // Start of current year
      case 1: // Month
        return DateTime(now.year, now.month, 1); // Start of current month
      case 2: // Week
        // Calculate start of week (Monday)
        return now.subtract(Duration(days: now.weekday - 1));
      case 3: // Today
        return DateTime(now.year, now.month, now.day); // Start of today
      default:
        return DateTime(now.year, 1, 1);
    }
  }

  DateTime _getEndDate(int timeFrameIndex) {
    final now = DateTime.now();

    switch (timeFrameIndex) {
      case 0: // Year
        return DateTime(now.year, 12, 31, 23, 59, 59); // End of current year
      case 1: // Month
        // Last day of current month
        final lastDay = DateTime(now.year, now.month + 1, 0);
        return DateTime(now.year, now.month, lastDay.day, 23, 59, 59);
      case 2: // Week
        // Calculate end of week (Saturday)
        final startOfWeek = now.subtract(Duration(days: now.weekday));
        return startOfWeek.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
      case 3: // Today
        return DateTime(now.year, now.month, now.day, 23, 59, 59); // End of today
      default:
        return DateTime(now.year, 12, 31, 23, 59, 59);
    }
  }

  Future<void> fetchTimeFrameBookings() async {
    final startDate = _getStartDate(selectedTimeFrameIndex);
    final endDate = _getEndDate(selectedTimeFrameIndex);
    timeFrameBookings = await FirebaseFirestoreSource().fetchBookingsByTimeFrame(
      AuthService.instance.currentUserModel!.id,
      startDate,
      endDate,
    );
    update();
  }

  onTimeFrameSelected(int index) {
    selectedTimeFrameIndex = index;
    fetchTimeFrameBookings();
  }

  Future<void> refreshDashboard() async {
    upcomingBookings.clear();

    await Future.wait([
      fetchUpcomingBookings(),
      fetchTimeFrameBookings(),
    ]);
  }

  Future<void> fetchUpcomingBookings() async {
    final bookings = await FirebaseFirestoreSource().fetchUpcomingBookingList(AuthService.instance.currentUserModel!.id);
    upcomingBookings.addAll(bookings);
    update();
  }

  Future<void> onBookingItemPressed(BookingModel booking) async {
    var result = await Get.toNamed(Routes.bookingDetail.replaceAll(':venueId', booking.venueId!).replaceAll(':bookingId', booking.id!));

    if (result == true) {
      fetchUpcomingBookings();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchUpcomingBookings();
    fetchTimeFrameBookings();
  }
}

class DashboardPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardPageController>(() => DashboardPageController());
  }
}
