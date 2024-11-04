import 'package:get/get.dart';
import '../../../../controllers/application_controller.dart';
import '../../../../core/routes/pages.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../data/models/venue_model.dart';

class VenueDetailPageController extends GetxController {
  final String venueId = Get.parameters['venueId']!;
  final ApplicationController applicationController = ApplicationController.instance;

  VenueModel? venue;

  Future<void> fetchVenue() async {
    venue = applicationController.venueList.value.firstWhereOrNull((venue) => venue.id == venueId);
    update();
  }

  Future<void> deleteVenue() async {
    await applicationController.deleteVenue(venueId);

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

    fetchVenue();

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
