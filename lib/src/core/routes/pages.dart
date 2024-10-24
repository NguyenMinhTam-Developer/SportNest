import 'package:get/get.dart';

import '../../features/authentication/controllers/sign_in_page_controller.dart';
import '../../features/authentication/controllers/sign_up_page_controller.dart';
import '../../features/authentication/pages/sign_in_page.dart';
import '../../features/authentication/pages/sign_up_page.dart';
import '../../features/booking/presentation/controllers/booking_detail_page_controller.dart';
import '../../features/booking/presentation/controllers/booking_list_page_controller.dart';
import '../../features/booking/presentation/controllers/booking_page_controller.dart';
import '../../features/booking/presentation/controllers/create_booking_page_controller.dart';
import '../../features/booking/presentation/controllers/update_booking_page_controller.dart';
import '../../features/booking/presentation/pages/booking_detail_page.dart';
import '../../features/booking/presentation/pages/booking_list_page.dart';
import '../../features/booking/presentation/pages/create_booking_page.dart';
import '../../features/booking/presentation/pages/update_booking_page.dart';
import '../../features/customer/presentation/controllers/create_customer_page_controller.dart';
import '../../features/customer/presentation/controllers/customer_detail_page_controller.dart';
import '../../features/customer/presentation/controllers/customer_list_page_controller.dart';
import '../../features/customer/presentation/controllers/update_customer_page_controller.dart';
import '../../features/customer/presentation/pages/create_customer_page.dart';
import '../../features/customer/presentation/pages/customer_detail_page.dart';
import '../../features/customer/presentation/pages/customer_list_page.dart';
import '../../features/customer/presentation/pages/update_customer_page.dart';
import '../../features/dashboard/presentation/controllers/dashboard_page_controller.dart';
import '../../features/home/presentation/controllers/home_page_controller.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/controllers/profile_page_controller.dart';
import '../../features/schedule/presentation/controllers/schedule_page_controller.dart';
import '../../features/units/presentation/controllers/create_unit_page_controller.dart';
import '../../features/units/presentation/controllers/unit_detail_page_controller.dart';
import '../../features/units/presentation/controllers/unit_list_page_controller.dart';
import '../../features/units/presentation/controllers/update_unit_page_controller.dart';
import '../../features/units/presentation/pages/create_unit_page.dart';
import '../../features/units/presentation/pages/unit_detail_page.dart';
import '../../features/units/presentation/pages/unit_list_page.dart';
import '../../features/units/presentation/pages/update_unit_page.dart';
import '../../features/venues/presentation/controllers/create_venue_page_controller.dart';
import '../../features/venues/presentation/controllers/update_venue_page_controller.dart';
import '../../features/venues/presentation/controllers/venue_detail_page_controller.dart';
import '../../features/venues/presentation/controllers/venue_list_page_controller.dart';
import '../../features/venues/presentation/pages/create_venue_page.dart';
import '../../features/venues/presentation/pages/update_venue_page.dart';
import '../../features/venues/presentation/pages/venue_detail_page.dart';
import '../../features/venues/presentation/pages/venue_list_page.dart';
import '../../modules/splash/controllers/splash_page_controller.dart';
import '../../modules/splash/pages/splash_page.dart';

part 'routes.dart';

abstract class AppPages {
  static const String initialRoute = Routes.splash;

  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashPageBinding(),
    ),
    GetPage(
      name: Routes.signIn,
      page: () => const SignInPage(),
      binding: SignInPageBinding(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpPage(),
      binding: SignUpPageBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomePageBinding(),
      bindings: [
        DashboardPageBinding(),
        BookingPageBinding(),
        SchedulePageBinding(),
        CustomerListPageBinding(),
        ProfilePageBinding(),
      ],
    ),

    // Venues
    GetPage(
      name: Routes.venues,
      page: () => const VenueListPage(),
      binding: VenueListPageBinding(),
    ),
    GetPage(
      name: Routes.createVenue,
      page: () => const CreateVenuePage(),
      binding: CreateVenuePageBinding(),
    ),
    GetPage(
      name: Routes.venueEdit,
      page: () => const UpdateVenuePage(),
      binding: UpdateVenuePageBinding(),
    ),
    GetPage(
      name: Routes.venueDetail,
      page: () => const VenueDetailPage(),
      binding: VenueDetailPageBinding(),
    ),

    // Booking
    GetPage(
      name: Routes.bookings,
      page: () => const BookingListPage(),
      binding: BookingListPageBinding(),
    ),
    GetPage(
      name: Routes.bookingCreate,
      page: () => const CreateBookingPage(),
      binding: CreateBookingPageBinding(),
    ),
    GetPage(
      name: Routes.bookingEdit,
      page: () => const UpdateBookingPage(),
      binding: UpdateBookingPageBinding(),
    ),
    GetPage(
      name: Routes.bookingDetail,
      page: () => const BookingDetailPage(),
      binding: BookingDetailPageBinding(),
    ),

    // Units
    GetPage(
      name: Routes.units,
      page: () => const UnitListPage(),
      binding: UnitListPageBinding(),
    ),
    GetPage(
      name: Routes.unitCreate,
      page: () => const CreateUnitPage(),
      binding: CreateUnitPageBinding(),
    ),
    GetPage(
      name: Routes.unitEdit,
      page: () => const UpdateUnitPage(),
      binding: UpdateUnitPageBinding(),
    ),
    GetPage(
      name: Routes.unitDetail,
      page: () => const UnitDetailPage(),
      binding: UnitDetailPageBinding(),
    ),

    // Customers
    GetPage(
      name: Routes.customers,
      page: () => const CustomerListPage(),
      binding: CustomerListPageBinding(),
      children: [
        GetPage(
          name: _trimString(Routes.customers, Routes.customerCreate),
          page: () => const CreateCustomerPage(),
          binding: CreateCustomerPageBinding(),
        ),
        GetPage(
          name: _trimString(Routes.customers, Routes.customerDetail),
          page: () => const CustomerDetailPage(),
          binding: CustomerDetailPageBinding(),
          children: [
            GetPage(
              name: _trimString(Routes.customerDetail, Routes.customerEdit),
              page: () => const UpdateCustomerPage(),
              binding: UpdateCustomerPageBinding(),
            ),
          ],
        ),
      ],
    ),
  ];

  /// Trims the [parent] string from the [child] string.
  /// Returns the trimmed string.
  static String _trimString(String parent, String child) {
    return child.replaceFirst(parent, '');
  }
}
