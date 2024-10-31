import 'package:get/get.dart';
import '../../../venues/presentation/controllers/venue_detail_page_controller.dart';

import '../../../../core/routes/pages.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../services/data_async_service.dart';

class UnitDetailPageController extends GetxController {
  final String _venueId = Get.parameters['venueId']!;
  final String _unitId = Get.parameters['unitId']!;

  final DataAsyncService dataAsyncService = DataAsyncService.instance;
  final VenueDetailPageController venueDetailPageController = VenueDetailPageController.instance;

  UnitModel? unit;

  Future<void> fetchUnit(String id) async {
    await venueDetailPageController.fetchVenue();
    unit = dataAsyncService.venueList.firstWhereOrNull((venue) => venue.id == _venueId)?.unitList.firstWhereOrNull((unit) => unit.id == id);
    update();
  }

  Future<void> onUnitEditPressed() async {
    var result = await Get.toNamed(
      Routes.unitEdit.replaceFirst(":venueId", _venueId).replaceFirst(":unitId", _unitId),
      arguments: unit,
    );

    if (result == true) {
      await fetchUnit(_unitId);
    }
  }

  Future<void> deleteUnit() async {
    await FirebaseFirestoreSource().deleteUnit(unit!.id);
    await VenueDetailPageController.instance.fetchVenue();

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
    unit = DataAsyncService.instance.venueList
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
