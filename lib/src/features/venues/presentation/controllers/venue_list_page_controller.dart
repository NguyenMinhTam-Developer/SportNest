import 'package:get/get.dart';
import '../../../../services/authentication_service.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';

import '../../../../data/models/venue_model.dart';

class VenueListPageController extends GetxController {
  Future<List<VenueModel>>? fetchVenueListFuture;

  Future<void> fetchVenues() async {
    fetchVenueListFuture = FirebaseFirestoreSource().fetchVenueList(AuthService.instance.currentUser!.uid);

    update();
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
