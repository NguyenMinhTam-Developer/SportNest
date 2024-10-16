import 'package:get/get.dart';
import 'package:sport_nest_flutter/src/data/models/booking_model.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../services/data_sync_service.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';

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

    await DataSyncService.instance.refreshVenueList();

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
}

class VenueDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueDetailPageController>(() => VenueDetailPageController());
  }
}
