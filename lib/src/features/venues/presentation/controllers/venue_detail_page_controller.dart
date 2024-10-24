import 'package:get/get.dart';
import '../../../../core/routes/pages.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import 'venue_list_page_controller.dart';

class VenueDetailPageController extends GetxController {
  final String venueId = Get.parameters['venueId']!;

  Future<VenueModel>? fetchVenueFuture;
  Future<List<UnitModel>>? fetchUnitListFuture;
  Future<List<BookingModel>>? fetchBookingListFuture;

  DateTime selectedDate = DateTime.now();

  Future<void> fetchVenue(String id) async {
    fetchVenueFuture = FirebaseFirestoreSource().fetchVenue(id);
    update();
  }

  Future<void> deleteVenue(String id) async {
    await FirebaseFirestoreSource().deleteVenue(id);

    await VenueListPageController.instance.fetchVenues();

    Get.back();
  }

  Future<void> fetchUnitList(String venueId) async {
    fetchUnitListFuture = FirebaseFirestoreSource().fetchUnitList(venueId);
    update();
  }

  Future<void> fetchBookingList(String venueId) async {
    fetchBookingListFuture = FirebaseFirestoreSource().fetchBookingList(venueId);
    update();
  }

  static VenueDetailPageController get instance {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(VenueDetailPageController());
    }
  }

  @override
  void onInit() {
    fetchVenue(venueId);

    fetchUnitList(venueId);

    fetchBookingList(venueId);

    super.onInit();
  }

  Future<void> onAddBooking() async {
    var result = await Get.toNamed(Routes.bookingCreate.replaceAll(':venueId', venueId));

    if (result == true) {
      fetchBookingList(venueId);
    }
  }

  Future<void> onUnitAddPress() async {
    var result = await Get.toNamed(Routes.unitCreate.replaceFirst(':venueId', venueId));

    if (result == true) {
      fetchUnitList(venueId);
    }
  }
}

class VenueDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueDetailPageController>(() => VenueDetailPageController());
  }
}
