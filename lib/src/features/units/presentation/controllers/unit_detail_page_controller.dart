import 'package:get/get.dart';
import '../../../../controllers/application_controller.dart';
import '../../../venues/presentation/controllers/venue_detail_page_controller.dart';

import '../../../../core/routes/pages.dart';
import '../../../../data/models/unit_model.dart';

class UnitDetailPageController extends GetxController {
  final String _venueId = Get.parameters['venueId']!;
  final String _unitId = Get.parameters['unitId']!;

  final ApplicationController applicationController = ApplicationController.instance;
  final VenueDetailPageController venueDetailPageController = VenueDetailPageController.instance;

  UnitModel? unit;
  bool isUpdated = false;

  Future<void> fetchUnit(String id) async {
    unit = applicationController.venueList.value.firstWhereOrNull((venue) => venue.id == _venueId)?.unitList.firstWhereOrNull((unit) => unit.id == id);
    update();
  }

  Future<void> onUnitEditPressed() async {
    var result = await Get.toNamed(
      Routes.unitEdit.replaceFirst(":venueId", _venueId).replaceFirst(":unitId", _unitId),
      arguments: unit,
    );

    if (result == true) {
      await fetchUnit(_unitId);
      await venueDetailPageController.fetchVenue();
    }
  }

  Future<void> deleteUnit() async {
    await applicationController.deleteUnit(unit!.id);
    await venueDetailPageController.fetchVenue();

    Get.back(closeOverlays: true);
  }

  static UnitDetailPageController get instance {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(UnitDetailPageController());
    }
  }

  @override
  void onInit() {
    unit = applicationController.venueList.value
        .firstWhereOrNull(
          (venue) => venue.id == _venueId,
        )
        ?.unitList
        .firstWhereOrNull(
          (unit) => unit.id == _unitId,
        );

    super.onInit();
  }
}

class UnitDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnitDetailPageController>(() => UnitDetailPageController());
  }
}
