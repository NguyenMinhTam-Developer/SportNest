import 'package:get/get.dart';

import '../data/models/unit_type_model.dart';
import '../data/sources/firebase/firebase_firestore_source.dart';

class AppService extends GetxService {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();

  List<UnitTypeModel> unitTypes = [];

  Future<AppService> init() async {
    await _fetchUnitTypes();
    return this;
  }

  Future<void> _fetchUnitTypes() async {
    try {
      unitTypes = await _firestoreSource.fetchUnitTypeList();
    } catch (e) {
      unitTypes = []; // Set to empty list in case of error
    }
  }

  static AppService get instance => Get.find<AppService>();
}
