import 'package:get/get.dart';

import '../../../../controllers/application_controller.dart';
import '../../../../core/routes/pages.dart';

class VenueListPageController extends GetxController {
  final ApplicationController applicationController = ApplicationController.instance;

  void onAddVenuePressed() => Get.toNamed(
        Routes.createVenue,
      );

  void onVenuePressed(String id) => Get.toNamed(
        Routes.venueDetail.replaceFirst(":venueId", id),
        arguments: applicationController.venueList.value.firstWhere((venue) => venue.id == id),
      );

  static VenueListPageController get instance {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(VenueListPageController());
    }
  }
}

class VenueListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueListPageController>(() => VenueListPageController());
  }
}
