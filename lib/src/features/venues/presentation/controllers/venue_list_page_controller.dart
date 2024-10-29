import 'package:get/get.dart';
import '../../../../core/routes/pages.dart';
import '../../../../services/authentication_service.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';

import '../../../../data/models/venue_model.dart';
import '../../../../services/data_async_service.dart';

class VenueListPageController extends GetxController {
  Future<List<VenueModel>>? fetchVenueListFuture;

  Future<void> fetchVenues() async {
    fetchVenueListFuture = FirebaseFirestoreSource().fetchVenueList(AuthService.instance.currentUser!.uid);

    DataAsyncService.instance?.refreshSchedulePage();

    update();
  }

  Future<void> onAddVenuePressed() async {
    var result = await Get.toNamed(Routes.createVenue);

    if (result == true) {
      fetchVenues();
    }
  }

  Future<void> onVenuePressed(String id) async {
    var result = await Get.toNamed(Routes.venueDetail.replaceFirst(":venueId", id));

    if (result == true) {
      fetchVenues();
    }
  }

  static VenueListPageController get instance {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(VenueListPageController());
    }
  }

  @override
  void onInit() {
    fetchVenues();
    super.onInit();
  }
}

class VenueListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueListPageController>(() => VenueListPageController());
  }
}
