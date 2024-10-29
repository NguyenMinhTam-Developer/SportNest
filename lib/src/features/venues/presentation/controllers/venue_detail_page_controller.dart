import 'package:get/get.dart';
import '../../../../core/routes/pages.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';

class VenueDetailPageController extends GetxController {
  final String venueId = Get.parameters['venueId']!;

  Future<VenueModel>? fetchVenueFuture;

  DateTime selectedDate = DateTime.now();

  bool isUpdated = false;

  Future<void> fetchVenue(String id) async {
    fetchVenueFuture = FirebaseFirestoreSource().fetchVenue(id);
    update();
  }

  Future<void> deleteVenue(String id) async {
    await FirebaseFirestoreSource().deleteVenue(id);

    Get.back(result: true, closeOverlays: true);
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

    super.onInit();
  }

  Future<void> onUnitAddPress() async {
    var result = await Get.toNamed(Routes.unitCreate.replaceFirst(':venueId', venueId));

    if (result == true) {
      fetchVenue(venueId);
    }
  }
}

class VenueDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueDetailPageController>(() => VenueDetailPageController());
  }
}
