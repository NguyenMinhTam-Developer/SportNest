import 'package:get/get.dart';
import '../../../../core/routes/pages.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../services/data_async_service.dart';

class VenueDetailPageController extends GetxController {
  final String venueId = Get.parameters['venueId']!;
  final DataAsyncService dataAsyncService = DataAsyncService.instance;

  VenueModel? venue;

  Future<void> fetchVenue() async {
    await dataAsyncService.fetchVenueList();
    venue = dataAsyncService.venueList.firstWhereOrNull((venue) => venue.id == venueId);
    update();
  }

  Future<void> deleteVenue() async {
    await FirebaseFirestoreSource().deleteVenue(venueId);
    await dataAsyncService.fetchVenueList();

    Get.back(result: true, closeOverlays: true);
  }

  Future<void> onUnitAddPressed() async {
    var result = await Get.toNamed(Routes.unitCreate.replaceFirst(':venueId', venueId));

    if (result == true) {
      await fetchVenue();
    }
  }

  Future<void> onUnitItemPressed(UnitModel unit) async {
    var result = await Get.toNamed(Routes.unitDetail.replaceFirst(':venueId', venueId).replaceFirst(':unitId', unit.id));

    if (result == true) {
      await fetchVenue();
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    venue = dataAsyncService.venueList.firstWhereOrNull((venue) => venue.id == venueId);
    update();
  }

  static VenueDetailPageController get instance {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(VenueDetailPageController());
    }
  }
}

class VenueDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueDetailPageController>(() => VenueDetailPageController());
  }
}
