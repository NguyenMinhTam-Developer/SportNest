import 'package:get/get.dart';
import '../../../../core/routes/pages.dart';
import 'venue_list_page_controller.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';

class VenueDetailPageController extends GetxController {
  final String venueId = Get.parameters['venueId']!;

  Future<VenueModel>? fetchVenueFuture;

  Future<void> fetchVenue(String id) async {
    fetchVenueFuture = FirebaseFirestoreSource().fetchVenue(id);
    update();
  }

  Future<void> deleteVenue(String id) async {
    await FirebaseFirestoreSource().deleteVenue(id);

    await VenueListPageController.instance.fetchVenues();

    Get.back();
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
}

class VenueDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueDetailPageController>(() => VenueDetailPageController());
  }
}
