import 'package:get/get.dart';
import 'package:sport_nest_flutter/src/data/models/unit_model.dart';

import '../data/models/unit_type_model.dart';
import '../data/models/venue_model.dart';
import '../data/sources/firebase/firebase_firestore_source.dart';
import '../features/dashboard/presentation/controllers/dashboard_page_controller.dart';
import '../features/schedule/presentation/controllers/schedule_page_controller.dart';
import 'authentication_controller.dart';

class ApplicationController extends GetxController {
  final AuthenticationController _authController = AuthenticationController.instance;
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();

  Rx<List<VenueModel>> venueList = Rx<List<VenueModel>>([]);
  RxBool isFetchingVenueList = RxBool(false);

  Rx<List<UnitTypeModel>> unitTypes = Rx<List<UnitTypeModel>>([]);

  // Venues & Units
  Future<void> fetchVenueList() async {
    if (_authController.currentUserModel != null) {
      isFetchingVenueList.value = true;
      venueList.value = await _firestoreSource.fetchVenueList(_authController.currentUserModel!.id);
      isFetchingVenueList.value = false;
    }
  }

  Future<void> createVenue(VenueModel venue) async {
    await _firestoreSource.createVenue(venue);
    await fetchVenueList();
  }

  Future<void> updateVenue(VenueModel venue) async {
    await _firestoreSource.updateVenue(venue);
    await fetchVenueList();
  }

  Future<void> deleteVenue(String id) async {
    await _firestoreSource.deleteVenue(id);
    await fetchVenueList();
  }

  Future<void> fetchUnitTypes() async {
    try {
      unitTypes.value = await _firestoreSource.fetchUnitTypeList();
    } catch (e) {
      unitTypes.value = [];
    }
  }

  Future<void> createUnit(UnitModel unit) async {
    await _firestoreSource.createUnit(unit);
    await fetchVenueList();
  }

  Future<void> updateUnit(UnitModel unit) async {
    await _firestoreSource.updateUnit(unit);
    await fetchVenueList();
  }

  Future<void> deleteUnit(String id) async {
    await _firestoreSource.deleteUnit(id);
    await fetchVenueList();
  }

  // Initialize & Remove

  Future<void> initializeApplicationData() async {
    await fetchUnitTypes();
    await fetchVenueList();

    SchedulePageController.instance?.initializeData();
  }

  Future<void> removeApplicationData() async {
    venueList.value = [];
    unitTypes.value = [];
  }

  // Async Data
  Future<void> asyncBookingData() async {
    SchedulePageController.instance?.fetchBookingList();
    DashboardPageController.instance.fetchTimeFrameBookings();
  }

  static ApplicationController get instance => Get.find<ApplicationController>();
}
