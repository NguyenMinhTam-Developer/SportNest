import 'package:get/get.dart';
import 'package:sport_nest_flutter/src/features/venues/presentation/controllers/venue_detail_page_controller.dart';

import '../../../../core/routes/pages.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';

class UnitListPageController extends GetxController {
  final venueId = Get.parameters['venueId']!;

  Future<List<UnitModel>>? fetchUnitListFuture;

  Future<void> fetchUnits(String venueId) async {
    fetchUnitListFuture = FirebaseFirestoreSource().fetchUnitList(venueId);
    update();
  }

  void onDetailPressed(UnitModel unit) async {
    var result = await Get.toNamed(
      Routes.unitDetail.replaceFirst(':venueId', venueId).replaceFirst(':unitId', unit.id),
    );

    if (result == true) {
      fetchUnits(venueId);
    }
  }

  static UnitListPageController get instance {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(UnitListPageController());
    }
  }

  @override
  void onInit() {
    fetchUnits(venueId);
    super.onInit();
  }
}

class UnitListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnitListPageController>(() => UnitListPageController());
  }
}
