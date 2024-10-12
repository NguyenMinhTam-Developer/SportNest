import 'package:get/get.dart';

import '../../../../data/models/unit_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import 'unit_list_page_controller.dart';

class UnitDetailPageController extends GetxController {
  Future<UnitModel>? fetchUnitFuture;
  UnitModel? unit;

  Future<void> fetchUnit(String id) async {
    fetchUnitFuture = FirebaseFirestoreSource().fetchUnit(id);
    unit = await fetchUnitFuture;
    update();
  }

  Future<void> deleteUnit() async {
    await FirebaseFirestoreSource().deleteUnit(unit!.id);
    await UnitListPageController.instance.fetchUnits(unit!.venueId);

    Get.back();
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
    fetchUnit(Get.parameters['unitId']!);
    super.onInit();
  }
}

class UnitDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnitDetailPageController>(() => UnitDetailPageController());
  }
}
